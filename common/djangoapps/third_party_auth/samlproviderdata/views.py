"""
    Viewset for auth/saml/v0/samlproviderdata
"""

from django.shortcuts import get_object_or_404
from edx_rbac.mixins import PermissionRequiredMixin
from edx_rest_framework_extensions.auth.jwt.authentication import JwtAuthentication
from rest_framework import permissions, viewsets
from rest_framework.authentication import SessionAuthentication
from rest_framework.exceptions import ParseError

from enterprise.models import EnterpriseCustomerIdentityProvider
from third_party_auth.utils import validate_uuid4_string

from ..models import SAMLProviderConfig, SAMLProviderData
from .serializers import SAMLProviderDataSerializer


class SAMLProviderDataMixin(object):
    authentication_classes = [JwtAuthentication, SessionAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = SAMLProviderDataSerializer


class SAMLProviderDataViewSet(PermissionRequiredMixin, SAMLProviderDataMixin, viewsets.ModelViewSet):
    """
    A View to handle SAMLProviderData CRUD.
    Uses the edx-rbac mixin PermissionRequiredMixin to apply enterprise authorization

    Usage:
        [HttpVerb] /auth/saml/v0/providerdata/
    """
    permission_required = 'enterprise.can_access_admin_dashboard'

    def get_queryset(self):
        """
        Find and return the matching providerid for the given enterprise uuid
        Note: There is no direct association between samlproviderdata and enterprisecustomer.
        So we make that association in code via samlproviderdata > samlproviderconfig ( via entity_id )
        then, we fetch enterprisecustomer via samlproviderconfig > enterprisecustomer ( via association table )
        """
        if self.requested_enterprise_uuid is None:
            raise ParseError('Required enterprise_customer_uuid is missing')
        enterprise_customer_idp = get_object_or_404(
            EnterpriseCustomerIdentityProvider,
            enterprise_customer__uuid=self.requested_enterprise_uuid
        )
        saml_provider = SAMLProviderConfig.objects.get(pk=enterprise_customer_idp.provider_id)
        return SAMLProviderData.objects.filter(entity_id=saml_provider.entity_id)

    @property
    def requested_enterprise_uuid(self):
        """
        The enterprise customer uuid from request params or post body
        """
        if self.request.method in ('POST', 'PATCH', 'DELETE'):
            uuid_str = self.request.POST.get('enterprise_customer_uuid')
            if uuid_str is None:
                raise ParseError('Required enterprise_customer_uuid is missing')
            return uuid_str
        else:
            uuid_str = self.request.query_params.get('enterprise_customer_uuid')
            if validate_uuid4_string(uuid_str) is False:
                raise ParseError('Invalid UUID enterprise_customer_id')
            return uuid_str

    def get_permission_object(self):
        """
        Retrive an EnterpriseCustomer to do auth against
        """
        return self.requested_enterprise_uuid
