import logging

from django.db.transaction import atomic
from django.utils.translation import gettext as _
import edx_api_doc_tools as apidocs
from opaque_keys import InvalidKeyError
from opaque_keys.edx.keys import UsageKey
from opaque_keys.edx.locator import CourseLocator
from rest_framework.exceptions import NotFound, PermissionDenied, ValidationError
from rest_framework.response import Response
from rest_framework.views import APIView
from common.djangoapps.student.auth import has_studio_read_access

from openedx.core.lib.api.view_utils import view_auth_classes
from xmodule import block_metadata_utils
from xmodule.modulestore.django import modulestore
from xmodule.modulestore.exceptions import ItemNotFoundError

from .block_serializer import XBlockSerializer
from .models import StagedContent
from .serializers import UserClipboardSerializer

log = logging.getLogger(__name__)


@view_auth_classes(is_authenticated=True)
class ClipboardEndpoint(APIView):
    """
    API Endpoint that can be used to get the status of the current user's
    clipboard or to POST some content to the clipboard.
    """

    @atomic
    @apidocs.schema(
        responses = {
            200: UserClipboardSerializer,
        }
    )
    def get(self, request):
        """
        Get the status of the user's clipboard. (Is there any content in the
        clipboard, and if so what?)
        """
        staged_content = StagedContent.get_clipboard_content(request.user.id)
        return Response(UserClipboardSerializer({"staged_content": staged_content}).data)

    @apidocs.schema(
        parameters=[
            apidocs.string_parameter(
                "usage_key",
                apidocs.ParameterLocation.BODY,
                description="Usage key to copy into the clipboard",
            ),
        ],
        responses={
            200: UserClipboardSerializer,
            403: "You do not have permission to read the specified usage key.",
            404: "The requested usage key does not exist.",
        },
    )
    @atomic
    def post(self, request):
        """
        Put some piece of content into the user's clipboard.
        """
        # Check if the content exists and the user has permission to read it.
        # Parse the usage key:
        try:
            usage_key = UsageKey.from_string(request.data["usage_key"])
        except (ValueError, InvalidKeyError):
            raise ValidationError('Invalid usage key')  # lint-amnesty, pylint: disable=raise-missing-from
        if usage_key.block_type in ('course', 'chapter', 'sequential'):
            raise ValidationError('Requested XBlock tree is too large')
        course_key = usage_key.context_key
        if not isinstance(course_key, CourseLocator):
            # In the future, we'll support libraries too but for now we don't.
            raise ValidationError('Invalid usage key: not a modulestore course')
        # Make sure the user has permission on that course
        if not has_studio_read_access(request.user, course_key):
            raise PermissionDenied("You must be a member of the course team in Studio to export OLX using this API.")

        # Get the OLX of the content
        try:
            block = modulestore().get_item(usage_key)
        except ItemNotFoundError:
            raise NotFound("The requested usage key does not exist.")

        block_data = XBlockSerializer(block)
        # Mark all of the user's existing StagedContent rows as EXPIRED
        StagedContent.objects.filter(user=request.user, purpose=StagedContent.Purpose.CLIPBOARD).update(
            status=StagedContent.Status.EXPIRED,
        )
        # Insert a new StagedContent row for this
        StagedContent.objects.create(
            user=request.user,
            purpose=StagedContent.Purpose.CLIPBOARD,
            status=StagedContent.Status.READY,
            block_type=usage_key.block_type,
            olx=block_data.olx_str,
            display_name=block_metadata_utils.display_name_with_default(block),
            source_context=usage_key.context_key,
        )

        # Return the current clipboard exactly as if GET was called:
        staged_content = StagedContent.get_clipboard_content(request.user.id)
        serializer = UserClipboardSerializer({"staged_content": staged_content})
        return Response(serializer.data)
