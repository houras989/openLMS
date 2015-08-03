""" Commerce API v1 view tests. """
from datetime import datetime
import itertools

import json
import ddt
from django.conf import settings
from django.contrib.auth.models import Permission
from django.core.urlresolvers import reverse
from django.test.utils import override_settings
import pytz
from rest_framework.utils.encoders import JSONEncoder
from xmodule.modulestore.tests.django_utils import ModuleStoreTestCase
from xmodule.modulestore.tests.factories import CourseFactory
from course_modes.models import CourseMode
from student.tests.factories import UserFactory
from verify_student.models import VerificationDeadline

PASSWORD = 'test'
JSON_CONTENT_TYPE = 'application/json'


class CourseApiViewTestMixin(object):
    """ Mixin for CourseApi views.

    Automatically creates a course and CourseMode.
    """

    def setUp(self):
        super(CourseApiViewTestMixin, self).setUp()
        self.course = CourseFactory.create()
        self.course_mode = CourseMode.objects.create(course_id=self.course.id, mode_slug=u'verified', min_price=100,
                                                     currency=u'USD', sku=u'ABC123')

    @staticmethod
    def _serialize_course_mode(course_mode, verification_deadline=None):
        """ Serialize a CourseMode to a dict. """
        # encode the datetime (if nonempty) using DRF's encoder, simplifying
        # equality assertions.
        expires = course_mode.expiration_datetime
        json_encoder = JSONEncoder()
        if expires is not None:
            expires = json_encoder.default(expires)

        if verification_deadline is not None and CourseMode.is_verified_mode(course_mode.to_tuple()):
            verification_deadline = json_encoder.default(verification_deadline)

        return {
            u'name': course_mode.mode_slug,
            u'currency': course_mode.currency.lower(),
            u'price': course_mode.min_price,
            u'sku': course_mode.sku,
            u'expires': expires,
            u'verification_deadline': verification_deadline,
        }

    @classmethod
    def _serialize_course(cls, course, modes=None, verification_deadline=None):
        """ Serializes a course to a Python dict. """
        data = {
            u'id': unicode(course.id),
            u'name': unicode(course.display_name),
            u'modes': []
        }

        modes = modes or []
        data[u'modes'] = [cls._serialize_course_mode(mode, verification_deadline) for mode in modes]

        return data


class CourseListViewTests(CourseApiViewTestMixin, ModuleStoreTestCase):
    """ Tests for CourseListView. """
    path = reverse('commerce_api:v1:courses:list')

    def test_authentication_required(self):
        """ Verify only authenticated users can access the view. """
        self.client.logout()
        response = self.client.get(self.path, content_type=JSON_CONTENT_TYPE)
        self.assertEqual(response.status_code, 401)

    def test_list(self):
        """ Verify the view lists the available courses and modes. """
        user = UserFactory.create()
        self.client.login(username=user.username, password=PASSWORD)
        response = self.client.get(self.path, content_type=JSON_CONTENT_TYPE)

        self.assertEqual(response.status_code, 200)
        actual = json.loads(response.content)
        expected = [self._serialize_course(self.course, [self.course_mode])]
        self.assertListEqual(actual, expected)


@ddt.ddt
class CourseRetrieveUpdateViewTests(CourseApiViewTestMixin, ModuleStoreTestCase):
    """ Tests for CourseRetrieveUpdateView. """

    def setUp(self):
        super(CourseRetrieveUpdateViewTests, self).setUp()
        self.path = reverse('commerce_api:v1:courses:retrieve_update', args=[unicode(self.course.id)])
        self.user = UserFactory.create()
        self.client.login(username=self.user.username, password=PASSWORD)

    @ddt.data('get', 'post', 'put')
    def test_authentication_required(self, method):
        """ Verify only authenticated users can access the view. """
        self.client.logout()
        response = getattr(self.client, method)(self.path, content_type=JSON_CONTENT_TYPE)
        self.assertEqual(response.status_code, 401)

    @ddt.data('post', 'put')
    def test_authorization_required(self, method):
        """ Verify create/edit operations require appropriate permissions. """
        response = getattr(self.client, method)(self.path, content_type=JSON_CONTENT_TYPE)
        self.assertEqual(response.status_code, 403)

    def test_retrieve(self):
        """ Verify the view displays info for a given course. """
        response = self.client.get(self.path, content_type=JSON_CONTENT_TYPE)
        self.assertEqual(response.status_code, 200)

        actual = json.loads(response.content)
        expected = self._serialize_course(self.course, [self.course_mode])
        self.assertEqual(actual, expected)

    def test_retrieve_invalid_course(self):
        """ The view should return HTTP 404 when retrieving data for a course that does not exist. """
        path = reverse('commerce_api:v1:courses:retrieve_update', args=['a/b/c'])
        response = self.client.get(path, content_type=JSON_CONTENT_TYPE)
        self.assertEqual(response.status_code, 404)

    def assert_course_updated(self, verification_deadline=None):
        """ Verify the API supports updating a course. """
        permission = Permission.objects.get(name='Can change course mode')
        self.user.user_permissions.add(permission)
        expiration_datetime = datetime.now(pytz.utc)
        expected_course_mode = CourseMode(
            mode_slug=u'verified',
            min_price=200,
            currency=u'USD',
            sku=u'ABC123',
            expiration_datetime=expiration_datetime
        )

        expected = self._serialize_course(self.course, [expected_course_mode], verification_deadline)

        response = self.client.put(self.path, json.dumps(expected), content_type=JSON_CONTENT_TYPE)
        self.assertEqual(response.status_code, 200)

        actual = json.loads(response.content)
        self.assertEqual(actual, expected)
        self.assertEqual(VerificationDeadline.deadline_for_course(self.course.id), verification_deadline)

    def test_update(self):
        """ Verify the view supports updating a course. """
        self.assert_course_updated(None)
        self.assert_course_updated(datetime(year=2015, month=1, day=1, tzinfo=pytz.utc))

    def test_update_overwrite(self):
        """ Verify that data submitted via PUT overwrites/deletes modes that are
        not included in the body of the request. """
        permission = Permission.objects.get(name='Can change course mode')
        self.user.user_permissions.add(permission)

        course_id = unicode(self.course.id)
        expected_course_mode = CourseMode(mode_slug=u'credit', min_price=500, currency=u'USD', sku=u'ABC123')
        expected = self._serialize_course(self.course, [expected_course_mode])
        path = reverse('commerce_api:v1:courses:retrieve_update', args=[course_id])
        response = self.client.put(path, json.dumps(expected), content_type=JSON_CONTENT_TYPE)
        self.assertEqual(response.status_code, 200)
        actual = json.loads(response.content)
        self.assertEqual(actual, expected)

        # The existing CourseMode should have been removed.
        self.assertFalse(CourseMode.objects.filter(id=self.course_mode.id).exists())

    @ddt.data(*itertools.product(
        ('honor', 'audit', 'verified', 'professional', 'no-id-professional'),
        (datetime.now(), None),
    ))
    @ddt.unpack
    def test_update_professional_expiration(self, mode_slug, expiration_datetime):
        """ Verify that pushing a mode with a professional certificate and an expiration datetime
        will be rejected (this is not allowed). """
        permission = Permission.objects.get(name='Can change course mode')
        self.user.user_permissions.add(permission)

        mode = self._serialize_course_mode(
            CourseMode(
                mode_slug=mode_slug,
                min_price=500,
                currency=u'USD',
                sku=u'ABC123',
                expiration_datetime=expiration_datetime
            )
        )
        course_id = unicode(self.course.id)
        payload = {u'id': course_id, u'modes': [mode]}
        path = reverse('commerce_api:v1:courses:retrieve_update', args=[course_id])

        expected_status = 400 if CourseMode.is_professional_slug(mode_slug) and expiration_datetime is not None else 200
        response = self.client.put(path, json.dumps(payload), content_type=JSON_CONTENT_TYPE)
        self.assertEqual(response.status_code, expected_status)

    def assert_can_create_course(self, **request_kwargs):
        """ Verify a course can be created by the view. """
        course = CourseFactory.create()
        expected_modes = [CourseMode(mode_slug=u'verified', min_price=150, currency=u'USD', sku=u'ABC123'),
                          CourseMode(mode_slug=u'honor', min_price=0, currency=u'USD', sku=u'DEADBEEF')]
        expected = self._serialize_course(course, expected_modes)
        path = reverse('commerce_api:v1:courses:retrieve_update', args=[unicode(course.id)])

        response = self.client.put(path, json.dumps(expected), content_type=JSON_CONTENT_TYPE, **request_kwargs)

        self.assertEqual(response.status_code, 201)

        actual = json.loads(response.content)
        self.assertEqual(actual, expected)

        # Verify the display names are correct
        course_modes = CourseMode.objects.filter(course_id=course.id)
        actual = [course_mode.mode_display_name for course_mode in course_modes]
        self.assertListEqual(actual, ['Verified Certificate', 'Honor Certificate'])

    def test_create_with_permissions(self):
        """ Verify the view supports creating a course as a user with the appropriate permissions. """
        permissions = Permission.objects.filter(name__in=('Can add course mode', 'Can change course mode'))
        for permission in permissions:
            self.user.user_permissions.add(permission)

        self.assert_can_create_course()

    @override_settings(EDX_API_KEY='edx')
    def test_create_with_api_key(self):
        """ Verify the view supports creating a course when authenticated with the API header key. """
        self.client.logout()
        self.assert_can_create_course(HTTP_X_EDX_API_KEY=settings.EDX_API_KEY)
