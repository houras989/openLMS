"""
Tests for custom DOT scopes backend.
"""
import ddt
from django.conf import settings
from django.test import TestCase

from openedx.core.djangoapps.oauth_dispatch.scopes import ApplicationModelScopes
from openedx.core.djangoapps.oauth_dispatch.tests.factories import ApplicationFactory


DEFAULT_SCOPES = settings.OAUTH2_DEFAULT_SCOPES.keys()


@ddt.ddt
class ApplicationModelScopesTestCase(TestCase):
    """
    Tests for the ApplicationModelScopes custom DOT scopes backend.
    """

    @ddt.data(
        (DEFAULT_SCOPES, []),
        (DEFAULT_SCOPES, ['unsupported_scope:read']),
        (DEFAULT_SCOPES + ['grades:read'], ['grades:read']),
        (DEFAULT_SCOPES + ['grades:read','certificates:read'], ['grades:read', 'certificates:read']),
    )
    @ddt.unpack
    def test_get_available_scopes(self, expected_result, application_scopes):
        """ Verify the settings backend returns the expected available scopes. """
        application = ApplicationFactory(scopes=application_scopes)
        scopes = ApplicationModelScopes()
        assert set(scopes.get_available_scopes(application)) == set(expected_result)
