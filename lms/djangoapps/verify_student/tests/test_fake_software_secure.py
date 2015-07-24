"""
Tests for the fake software secure response.
"""

from django.test import TestCase

from mock import patch
from student.tests.factories import UserFactory
from util.testing import reset_urls
from verify_student.models import SoftwareSecurePhotoVerification

from django.conf import settings


class SoftwareSecureFakeViewTest(TestCase):
    """
    Base class to test the fake software secure view.
    """
    def setUp(self):
        self.user = UserFactory.create(username="test", password="test")
        self.attempt = SoftwareSecurePhotoVerification.objects.create(user=self.user)
        self.client.login(username="test", password="test")
        reset_urls(urlconf_modules=['verify_student.urls'])

    def tearDown(self):
        reset_urls()


class SoftwareSecureFakeViewDisabledTest(SoftwareSecureFakeViewTest):
    """
    Test the fake software secure response when feature flag
    'ENABLE_SOFTWARE_SECURE_FAKE' is not enabled.
    """
    def setUp(self):
        with patch.dict('django.conf.settings.FEATURES', {'ENABLE_SOFTWARE_SECURE_FAKE': False}):
            super(SoftwareSecureFakeViewDisabledTest, self).setUp()

    def test_get_method_without_enable_feature_flag(self):
        """
        Test that the user gets 404 response if the feature flag
        'ENABLE_SOFTWARE_SECURE_FAKE' is not enabled.
        """
        response = self.client.get(
            '/verify_student/software-secure-fake-response'
        )

        self.assertEqual(response.status_code, 404)


class SoftwareSecureFakeViewEnabledTest(SoftwareSecureFakeViewTest):
    """
    Test the fake software secure response when feature flag
    'ENABLE_SOFTWARE_SECURE_FAKE' is enabled.
    """
    def setUp(self):
        with patch.dict('django.conf.settings.FEATURES', {'ENABLE_SOFTWARE_SECURE_FAKE': True}):
            super(SoftwareSecureFakeViewEnabledTest, self).setUp()

    def test_get_method_without_logged_in_user(self):
        """
        Test that the user gets 302 response if that user is not logged in.
        """
        self.client.logout()
        response = self.client.get(
            '/verify_student/software-secure-fake-response'
        )
        self.assertEqual(response.status_code, 302)

    def test_get_method(self):
        """
        Test that GET method of fake software secure view uses the most recent
        attempt for the logged-in user.
        """
        response = self.client.get(
            '/verify_student/software-secure-fake-response'
        )

        self.assertEqual(response.status_code, 200)
        self.assertIn('EdX-ID', response.content)
        self.assertIn('results_callback', response.content)
