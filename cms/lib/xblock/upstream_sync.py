"""
Synchronize content and settings from upstream blocks to their downstream usages.

At the time of writing, we assume that for any upstream-downstream linkage:
* The upstream is a Component from a Learning Core-backed Content Library.
* The downstream is a block of matching type in a SplitModuleStore-backed Courses.
* They are both on the same Open edX instance.

HOWEVER, those assumptions may loosen in the future. So, we consider these to be INTERNAL ASSUMPIONS that should not be
exposed through this module's public Python interface.
"""
import typing as t
from dataclasses import dataclass, asdict

from django.contrib.auth import get_user_model
from django.utils.translation import gettext_lazy as _
from opaque_keys import InvalidKeyError
from opaque_keys.edx.keys import UsageKey, CourseKey
from opaque_keys.edx.locator import LibraryUsageLocatorV2
from rest_framework.exceptions import NotFound
from xblock.exceptions import XBlockNotFoundError
from xblock.fields import Scope, String, Integer, List
from xblock.core import XBlockMixin, XBlock

import openedx.core.djangoapps.xblock.api as xblock_api
from openedx.core.djangoapps.content_libraries.api import get_library_block


User = get_user_model()


class BadUpstream(Exception):
    """
    Reference to upstream content is malformed, invalid, and/or inaccessible.

    Should be constructed with a human-friendly, localized, PII-free message, suitable for API responses and UI display.
    """


class BadDownstream(Exception):
    """
    Downstream content does not support sync.

    Should be constructed with a human-friendly, localized, PII-free message, suitable for API responses and UI display.
    """


@dataclass(frozen=True)
class UpstreamInfo:
    """
    Metadata about a downstream's relationship with an upstream.
    """
    upstream_ref: str  # Reference to the upstream content, e.g., a serialized library block usage key.
    current_version: int  # Version of the upstream to which the downstream was last synced.
    latest_version: int | None  # Latest version of the upstream that's available, or None if it couldn't be loaded.


def sync_from_upstream(downstream: XBlock, user: User, *, apply_updates: bool) -> None:
    """
    @@TODO docstring

    Does not save `downstream` to the store. That is left up to the caller.

    Raises: BadUpstream
    """

    # No upstream -> no sync.
    if not downstream.upstream:
        return

    # Try to load the upstream.
    upstream_info = inspect_upstream_link(downstream)  # Can raise BadUpstream
    try:
        upstream = xblock_api.load_block(UsageKey.from_string(downstream.upstream), user)
    except NotFound as exc:
        raise BadUpstream(_("Linked library item could not be loaded: {}").format(downstream.upstream)) from exc

    # For every field...
    customizable_fields_to_restore_fields = downstream.get_customizable_fields()
    for field_name, field in upstream.__class__.fields.items():

        # ...(ignoring fields that aren't set in the authoring environment)...
        if field.scope not in [Scope.content, Scope.settings]:
            continue

        # ...if the field *can be* customized (whether or not it *has been* customized), then write its latest
        #    upstream value to a hidden field, allowing authors to restore it as desired.
        #    Example: this sets `downstream.upstream_display_name = upstream.display_name`.
        upstream_value = getattr(upstream, field_name)
        if restore_field_name := customizable_fields_to_restore_fields.get(field.name):
            setattr(downstream, restore_field_name, upstream_value)

        # ...if we're applying updates, *and* the field hasn't been customized, then update the downstream value.
        #    This is the part of the sync that actually pulls in updated upstream content.
        #    Example: this sets `downstream.display_name = upstream.display_name`.
        if apply_updates and field_name not in downstream.downstream_customized:
            setattr(downstream, field_name, upstream_value)

    # Done syncing. Record the latest upstream version for future reference.
    downstream.upstream_version = upstream_info.latest_version


def inspect_upstream_link(downstream: XBlock) -> UpstreamInfo | None:
    """
    Get info on a block's relationship with its upstream without actually loading any upstream content.

    Currently, the only supported upstream are LC-backed Library Components. This may change in the future (see
    module docstring).

    Raises: BadUpstream, BadDownstream
    """
    if not downstream.upstream:
        return None
    if not isinstance(downstream.usage_key.context_key, CourseKey):
        raise BadDownstream(_("Cannot update content because it does not belong to a course."))
    if downstream.has_children:
        raise BadDownstream(_("Updating content with children is not yet supported."))
    try:
        upstream_key = LibraryUsageLocatorV2.from_string(downstream.upstream)
    except InvalidKeyError as exc:
        raise BadUpstream(_("Reference to linked library item is malformed")) from exc
    downstream_type = downstream.usage_key.block_type
    if upstream_key.block_type != downstream_type:
        # Note: Currently, we strictly enforce that the downstream and upstream block_types must exactly match.
        #       It could be reasonable to relax this requirement in the future if there's product need for it.
        #       For example, there's no reason that a StaticTabBlock couldn't take updates from an HtmlBlock.
        raise BadUpstream(
            _("Content type mismatch. {downstream_type} content cannot be linked to {upstream_type} content.").format(
                downstream_type=downstream_type, upstream_type=upstream_key.block_type
            )
        ) from TypeError(
            f"downstream block '{downstream.usage_key}' is linked to "
            f"upstream block of different type '{upstream_key}'"
        )
    try:
        lib_meta = get_library_block(upstream_key)
    except XBlockNotFoundError as exc:
        raise BadUpstream(_("Linked library item was not found in the system")) from exc
    return UpstreamInfo(
        upstream_ref=downstream.upstream,
        current_version=downstream.upstream_version,
        latest_version=(lib_meta.version_num if lib_meta else None),
    )


def inspect_upstream_link_as_json(downstream: XBlock) -> dict[str, t.Any] | None:
    """
    Same as `inspect_upstream_link`, but return a dict (or None) suitable for a JSON API reseponse.

    Does not raise.
    In the event of a BadUpstream/BadDownstream, returns the error message in the `warning` field.
    """
    try:
        upstream_info = inspect_upstream_link(downstream)
    except (BadDownstream, BadUpstream) as exc:
        return {
            "upstream_ref": downstream.upstream,
            "current_version": downstream.upstream_version,
            "latest_version": None,
            "can_sync": False,
            "warning": str(exc),
        }
    if not upstream_info:
        return None
    return {
        **asdict(upstream_info),
        "can_sync": (
            upstream_info.upstream_ref and
            upstream_info.latest_version and
            upstream_info.latest_version > upstream_info.current_version
        ),
        "warning": None,
    }


class UpstreamSyncMixin(XBlockMixin):
    """
    Allows an XBlock in the CMS to be associated & synced with an upstream.
    Mixed into CMS's XBLOCK_MIXINS, but not LMS's.
    """

    # Upstream synchronization metadata fields
    upstream = String(
        help=(
            "The usage key of a block (generally within a content library) which serves as a source of upstream "
            "updates for this block, or None if there is no such upstream. Please note: It is valid for this "
            "field to hold a usage key for an upstream block that does not exist (or does not *yet* exist) on "
            "this instance, particularly if this downstream block was imported from a different instance."
        ),
        default=None, scope=Scope.settings, hidden=True, enforce_type=True
    )
    upstream_version = Integer(
        help=(
            "Record of the upstream block's version number at the time this block was created from it. If "
            "upstream_version is smaller than the upstream block's latest version, then the user will be able "
            "to sync updates into this downstream block."
        ),
        default=None, scope=Scope.settings, hidden=True, enforce_type=True,
    )
    downstream_customized = List(
        help=(
            "Names of the fields which have values set on the upstream block yet have been explicitly "
            "overridden on this downstream block. Unless explicitly cleared by the user, these customizations "
            "will persist even when updates are synced from the upstream."
        ),
        default=[], scope=Scope.settings, hidden=True, enforce_type=True,
    )

    # Store upstream defaults for customizable fields.
    upstream_display_name = String(
        help=("The value of display_name on the linked upstream block."),
        default=None, scope=Scope.settings, hidden=True, enforce_type=True,
    )
    upstream_max_attempts = Integer(
        help=("The value of max_attempts on the linked upstream block."),
        default=None, scope=Scope.settings, hidden=True, enforce_type=True,
    )

    @classmethod
    def get_customizable_fields(cls) -> dict[str, str]:
        """
        Mapping from each customizable field to field which stores its upstream default.

        XBlocks outside of edx-platform can override this in order to set up their own customizable fields.
        """
        return {
            "display_name": "upstream_display_name",
            "max_attempts": "upstream_max_attempts",
        }

    def save(self, *args, **kwargs):
        """
        Update `downstream_customized` when a customizable field is modified.
        """
        # Loop through all the fields that are potentially cutomizable.
        for field_name, restore_field_name in self.get_customizable_fields().items():

            # If the field is already marked as customized, then move on so that we don't
            # unneccessarily query the block for its current value.
            if field_name in self.downstream_customized:
                continue

            # If this field's value doesn't match the synced upstream value, then mark the field
            # as customized so that we don't clobber it later when syncing.
            if getattr(self, field_name) != getattr(self, restore_field_name):
                self.downstream_customized.append(field_name)

        super().save(*args, **kwargs)
