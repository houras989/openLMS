""" API Views for syncing upstream content to downstream content """

import edx_api_doc_tools as apidocs
from opaque_keys import InvalidKeyError
from opaque_keys.edx.keys import UsageKey
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.views import APIView
from cms.lib.xblock.upstream_sync import sync_from_upstream, BadUpstream, BadDownstream
from common.djangoapps.student.auth import has_studio_write_access
from openedx.core.lib.api.view_utils import (
    DeveloperErrorViewMixin,
    view_auth_classes,
)
from xmodule.modulestore.django import modulestore
from xmodule.modulestore.exceptions import ItemNotFoundError


@view_auth_classes(is_authenticated=True)
class UpstreamSyncView(DeveloperErrorViewMixin, APIView):
    """
    @@TODO
    """

    @apidocs.schema(
        parameters=[
            apidocs.string_parameter(
                "course_id", apidocs.ParameterLocation.PATH, description="Course ID"
            ),
        ],
        responses={
            200: None,
            400: "Downstream block ID is invalid.",
            401: "The requester is not authenticated.",
            403: "The requester cannot modify the specified downstream block.",
            404: "The specified downstream block does not exist.",
            422: "Failed to sync content.",
        },
    )
    def post(self, request: Request, usage_key_string: str):
        """
        Pull latest updates to the block at {usage_key_string} from its linked upstream content.

        **Example Request**

            POST /api/contentstore/v1/upstream_sync/{usage_key_string}

        **Response Values**

        If the request is successful, an HTTP 200 "OK" response is returned, with no body.
        If the request fails, an HTTP 4xx response is returned, with an error message.
        """
        try:
            usage_key = UsageKey.from_string(usage_key_string)
        except InvalidKeyError:
            return Response("Invalid block key", status=400)
        if not has_studio_write_access(request.user, usage_key.context_key):
            self.permission_denied(request)

        store = modulestore()
        with store.bulk_operations(usage_key.context_key):
            try:
                downstream = store.get_item(usage_key)
            except ItemNotFoundError:
                return Response("Block not found", status=404)
            try:
                sync_from_upstream(downstream, request.user, apply_updates=True)
            except (BadUpstream, BadDownstream) as exc:
                return Response(str(exc), status=422)
            downstream.save()
            store.update_item(downstream, request.user.id)
            return Response()
