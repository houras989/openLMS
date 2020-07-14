"""
Viewset for auth/saml/v0/samlproviderconfig
"""
from logging import getLogger

from django.http import Http404, HttpResponseNotFound
from django.shortcuts import get_object_or_404
from rest_framework import permissions, viewsets
from rest_framework.authentication import SessionAuthentication
from rest_framework.decorators import detail_route, list_route

from edx_rbac.mixins import PermissionRequiredMixin
from edx_rbac.decorators import permission_required
from edx_rest_framework_extensions.auth.jwt.authentication import JwtAuthentication
from enterprise.models import EnterpriseCustomerIdentityProvider

from openedx.features.enterprise_support.utils import fetch_enterprise_customer_by_id

from ..models import SAMLProviderConfig
from .serializers import SAMLProviderConfigSerializer


LOGGER = getLogger(__name__)

class SAMLProviderMixin(object):
    authentication_classes = [JwtAuthentication, SessionAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = SAMLProviderConfigSerializer


class SAMLProviderConfigViewSet(PermissionRequiredMixin, SAMLProviderMixin, viewsets.ModelViewSet):
    """
    A View to handle SAMLProviderConfig CRUD

    Usage:
        [HttpVerb] /auth/saml/v0/provider_config/?enterprise-id=uuid

    permission_required refers to the Django permission name defined
    in enterprise.rules.
    The associated rule will allow edx-rbac to check if the EnterpriseCustomer
    returned by the get_permission_object method here, can be
    accessed by the user making this request (request.user)
    Access is only allowed if the user has the system role
    of 'ENTERPRISE_ADMIN' which is defined in enterprise.constants
    """
    permission_required = 'enterprise.can_access_admin_dashboard'

    def get_queryset(self):
        """
        Find and return the matching providerconfig for the given enterprise uuid
        if an association exists in EnterpriseCustomerIdentityProvider model
        """
        if self.requested_enterprise_uuid is None:
            raise Http404('Required enterprise_customer_uuid is missing')
        enterprise_customer_idp = get_object_or_404(EnterpriseCustomerIdentityProvider,
            enterprise_customer__uuid=self.requested_enterprise_uuid)
        return SAMLProviderConfig.objects.filter(pk=enterprise_customer_idp.provider_id)

    @property
    def requested_enterprise_uuid(self):
        """
        The enterprise customer uuid from request params or post body
        """
        if self.request.method == "POST":
            uuid_str = self.request.POST.get('enterprise_customer_uuid')
            if uuid_str is None:
              raise Http404('Required enterprise_customer_uuid is missing')
            return uuid_str
        else:
            return self.request.query_params.get('enterprise_customer_uuid')

    def get_permission_object(self):
        """
        Retrive an EnterpriseCustomer uuid to do auth against
        Right now this is the same as from the request object
        meaning that only users belonging to the same enterprise
        can access these endpoints, we have to sort out the operator role use case
        """
        return self.requested_enterprise_uuid
