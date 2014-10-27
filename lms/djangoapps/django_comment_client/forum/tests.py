import json
import logging

from django.http import Http404
from django.test.utils import override_settings
from django.test.client import Client, RequestFactory
from xmodule.modulestore.tests.factories import CourseFactory, ItemFactory
from student.tests.factories import UserFactory, CourseEnrollmentFactory
from edxmako.tests import mako_middleware_process_request
from xmodule.modulestore.tests.django_utils import ModuleStoreTestCase, mixed_store_config
from django.core.urlresolvers import reverse
from util.testing import UrlResetMixin
from django_comment_client.tests.group_id import (
    CohortedTopicGroupIdTestMixin,
    NonCohortedTopicGroupIdTestMixin
)
from django_comment_client.tests.unicode import UnicodeTestMixin
from django_comment_client.tests.utils import CohortedContentTestCase
from django_comment_client.forum import views
from django_comment_client.utils import strip_none

from courseware.tests.modulestore_config import TEST_DATA_DIR
from courseware.courses import UserNotEnrolled
from nose.tools import assert_true  # pylint: disable=E0611
from mock import patch, Mock, ANY, call

from course_groups.models import CourseUserGroup

TEST_DATA_MONGO_MODULESTORE = mixed_store_config(TEST_DATA_DIR, {}, include_xml=False)

log = logging.getLogger(__name__)

# pylint: disable=C0111


@override_settings(MODULESTORE=TEST_DATA_MONGO_MODULESTORE)
class ViewsExceptionTestCase(UrlResetMixin, ModuleStoreTestCase):

    @patch.dict("django.conf.settings.FEATURES", {"ENABLE_DISCUSSION_SERVICE": True})
    def setUp(self):

        # Patching the ENABLE_DISCUSSION_SERVICE value affects the contents of urls.py,
        # so we need to call super.setUp() which reloads urls.py (because
        # of the UrlResetMixin)
        super(ViewsExceptionTestCase, self).setUp()

        # create a course
        self.course = CourseFactory.create(org='MITx', course='999',
                                           display_name='Robot Super Course')

        # Patch the comment client user save method so it does not try
        # to create a new cc user when creating a django user
        with patch('student.models.cc.User.save'):
            uname = 'student'
            email = 'student@edx.org'
            password = 'test'

            # Create the student
            self.student = UserFactory(username=uname, password=password, email=email)

            # Enroll the student in the course
            CourseEnrollmentFactory(user=self.student, course_id=self.course.id)

            # Log the student in
            self.client = Client()
            assert_true(self.client.login(username=uname, password=password))

    @patch('student.models.cc.User.from_django_user')
    @patch('student.models.cc.User.active_threads')
    def test_user_profile_exception(self, mock_threads, mock_from_django_user):

        # Mock the code that makes the HTTP requests to the cs_comment_service app
        # for the profiled user's active threads
        mock_threads.return_value = [], 1, 1

        # Mock the code that makes the HTTP request to the cs_comment_service app
        # that gets the current user's info
        mock_from_django_user.return_value = Mock()

        url = reverse('django_comment_client.forum.views.user_profile',
                      kwargs={'course_id': self.course.id.to_deprecated_string(), 'user_id': '12345'})  # There is no user 12345
        self.response = self.client.get(url)
        self.assertEqual(self.response.status_code, 404)

    @patch('student.models.cc.User.from_django_user')
    @patch('student.models.cc.User.subscribed_threads')
    def test_user_followed_threads_exception(self, mock_threads, mock_from_django_user):

        # Mock the code that makes the HTTP requests to the cs_comment_service app
        # for the profiled user's active threads
        mock_threads.return_value = [], 1, 1

        # Mock the code that makes the HTTP request to the cs_comment_service app
        # that gets the current user's info
        mock_from_django_user.return_value = Mock()

        url = reverse('django_comment_client.forum.views.followed_threads',
                      kwargs={'course_id': self.course.id.to_deprecated_string(), 'user_id': '12345'})  # There is no user 12345
        self.response = self.client.get(url)
        self.assertEqual(self.response.status_code, 404)


def make_mock_thread_data(text, thread_id, include_children, group_id=None, group_name=None, commentable_id=None):
    thread_data = {
        "id": thread_id,
        "type": "thread",
        "title": text,
        "body": text,
        "commentable_id": commentable_id or "dummy_commentable_id",
        "resp_total": 42,
        "resp_skip": 25,
        "resp_limit": 5,
        "group_id": group_id
    }
    if group_id is not None:
        thread_data['group_name'] = group_name
    if include_children:
        thread_data["children"] = [{
            "id": "dummy_comment_id",
            "type": "comment",
            "body": text,
        }]
    return thread_data


def make_mock_request_impl(text, thread_id="dummy_thread_id", group_id=None, commentable_id=None):
    def mock_request_impl(*args, **kwargs):
        url = args[1]
        data = None
        if url.endswith("threads") or url.endswith("user_profile"):
            data = {
                "collection": [make_mock_thread_data(text, thread_id, False, group_id=group_id, commentable_id=commentable_id)]
            }
        elif thread_id and url.endswith(thread_id):
            data = make_mock_thread_data(text, thread_id, True, group_id=group_id)
        elif "/users/" in url:
            data = {
                "default_sort_key": "date",
                "upvoted_ids": [],
                "downvoted_ids": [],
                "subscribed_thread_ids": [],
            }
            # comments service adds these attributes when course_id param is present
            if kwargs.get('params', {}).get('course_id'):
                data.update({
                    "threads_count": 1,
                    "comments_count": 2
                })
        if data:
            return Mock(status_code=200, text=json.dumps(data), json=Mock(return_value=data))
        return Mock(status_code=404)
    return mock_request_impl


class StringEndsWithMatcher(object):
    def __init__(self, suffix):
        self.suffix = suffix

    def __eq__(self, other):
        return other.endswith(self.suffix)


class PartialDictMatcher(object):
    def __init__(self, expected_values):
        self.expected_values = expected_values

    def __eq__(self, other):
        return all([
            key in other and other[key] == value
            for key, value in self.expected_values.iteritems()
        ])


@override_settings(MODULESTORE=TEST_DATA_MONGO_MODULESTORE)
@patch('requests.request')
class SingleThreadTestCase(ModuleStoreTestCase):
    def setUp(self):
        self.course = CourseFactory.create()
        self.student = UserFactory.create()
        CourseEnrollmentFactory.create(user=self.student, course_id=self.course.id)

    def test_ajax(self, mock_request):
        text = "dummy content"
        thread_id = "test_thread_id"
        mock_request.side_effect = make_mock_request_impl(text, thread_id)

        request = RequestFactory().get(
            "dummy_url",
            HTTP_X_REQUESTED_WITH="XMLHttpRequest"
        )
        request.user = self.student
        response = views.single_thread(
            request,
            self.course.id.to_deprecated_string(),
            "dummy_discussion_id",
            "test_thread_id"
        )

        self.assertEquals(response.status_code, 200)
        response_data = json.loads(response.content)
        # strip_none is being used to perform the same transform that the
        # django view performs prior to writing thread data to the response
        self.assertEquals(
            response_data["content"],
            strip_none(make_mock_thread_data(text, thread_id, True))
        )
        mock_request.assert_called_with(
            "get",
            StringEndsWithMatcher(thread_id),  # url
            data=None,
            params=PartialDictMatcher({"mark_as_read": True, "user_id": 1, "recursive": True}),
            headers=ANY,
            timeout=ANY
        )

    def test_skip_limit(self, mock_request):
        text = "dummy content"
        thread_id = "test_thread_id"
        response_skip = "45"
        response_limit = "15"
        mock_request.side_effect = make_mock_request_impl(text, thread_id)

        request = RequestFactory().get(
            "dummy_url",
            {"resp_skip": response_skip, "resp_limit": response_limit},
            HTTP_X_REQUESTED_WITH="XMLHttpRequest"
        )
        request.user = self.student
        response = views.single_thread(
            request,
            self.course.id.to_deprecated_string(),
            "dummy_discussion_id",
            "test_thread_id"
        )
        self.assertEquals(response.status_code, 200)
        response_data = json.loads(response.content)
        # strip_none is being used to perform the same transform that the
        # django view performs prior to writing thread data to the response
        self.assertEquals(
            response_data["content"],
            strip_none(make_mock_thread_data(text, thread_id, True))
        )
        mock_request.assert_called_with(
            "get",
            StringEndsWithMatcher(thread_id),  # url
            data=None,
            params=PartialDictMatcher({
                "mark_as_read": True,
                "user_id": 1,
                "recursive": True,
                "resp_skip": response_skip,
                "resp_limit": response_limit,
            }),
            headers=ANY,
            timeout=ANY
        )

    def test_post(self, mock_request):
        request = RequestFactory().post("dummy_url")
        response = views.single_thread(
            request,
            self.course.id.to_deprecated_string(),
            "dummy_discussion_id",
            "dummy_thread_id"
        )
        self.assertEquals(response.status_code, 405)

    def test_not_found(self, mock_request):
        request = RequestFactory().get("dummy_url")
        request.user = self.student
        # Mock request to return 404 for thread request
        mock_request.side_effect = make_mock_request_impl("dummy", thread_id=None)
        self.assertRaises(
            Http404,
            views.single_thread,
            request,
            self.course.id.to_deprecated_string(),
            "test_discussion_id",
            "test_thread_id"
        )


@override_settings(MODULESTORE=TEST_DATA_MONGO_MODULESTORE)
@patch('requests.request')
class SingleCohortedThreadTestCase(CohortedContentTestCase):
    def _create_mock_cohorted_thread(self, mock_request):
        self.mock_text = "dummy content"
        self.mock_thread_id = "test_thread_id"
        mock_request.side_effect = make_mock_request_impl(
            self.mock_text, self.mock_thread_id,
            group_id=self.student_cohort.id
        )

    def test_ajax(self, mock_request):
        self._create_mock_cohorted_thread(mock_request)

        request = RequestFactory().get(
            "dummy_url",
            HTTP_X_REQUESTED_WITH="XMLHttpRequest"
        )
        request.user = self.student
        response = views.single_thread(
            request,
            self.course.id.to_deprecated_string(),
            "dummy_discussion_id",
            self.mock_thread_id
        )

        self.assertEquals(response.status_code, 200)
        response_data = json.loads(response.content)
        self.assertEquals(
            response_data["content"],
            make_mock_thread_data(
                self.mock_text, self.mock_thread_id, True,
                group_id=self.student_cohort.id,
                group_name=self.student_cohort.name,
            )
        )

    def test_html(self, mock_request):
        self._create_mock_cohorted_thread(mock_request)

        request = RequestFactory().get("dummy_url")
        request.user = self.student
        mako_middleware_process_request(request)
        response = views.single_thread(
            request,
            self.course.id.to_deprecated_string(),
            "dummy_discussion_id",
            self.mock_thread_id
        )

        self.assertEquals(response.status_code, 200)
        self.assertEqual(response['Content-Type'], 'text/html; charset=utf-8')
        html = response.content

        # Verify that the group name is correctly included in the HTML
        self.assertRegexpMatches(html, r'&#34;group_name&#34;: &#34;student_cohort&#34;')


@patch('lms.lib.comment_client.utils.requests.request')
class SingleThreadAccessTestCase(CohortedContentTestCase):
    def call_view(self, mock_request, commentable_id, user, group_id, thread_group_id=None, pass_group_id=True):
        thread_id = "test_thread_id"
        mock_request.side_effect = make_mock_request_impl("dummy context", thread_id, group_id=thread_group_id)

        request_data = {}
        if pass_group_id:
            request_data["group_id"] = group_id
        request = RequestFactory().get(
            "dummy_url",
            data=request_data,
            HTTP_X_REQUESTED_WITH="XMLHttpRequest"
        )
        request.user = user
        return views.single_thread(
            request,
            self.course.id.to_deprecated_string(),
            commentable_id,
            thread_id
        )

    def test_student_non_cohorted(self, mock_request):
        resp = self.call_view(mock_request, "non_cohorted_topic", self.student, self.student_cohort.id)
        self.assertEqual(resp.status_code, 200)

    def test_student_same_cohort(self, mock_request):
        resp = self.call_view(
            mock_request,
            "cohorted_topic",
            self.student,
            self.student_cohort.id,
            thread_group_id=self.student_cohort.id
        )
        self.assertEqual(resp.status_code, 200)

    # this test ensures that a thread response from the cs with group_id: null
    # behaves the same as a thread response without a group_id (see: TNL-444)
    def test_student_global_thread_in_cohorted_topic(self, mock_request):
        resp = self.call_view(
            mock_request,
            "cohorted_topic",
            self.student,
            self.student_cohort.id,
            thread_group_id=None
        )
        self.assertEqual(resp.status_code, 200)

    def test_student_different_cohort(self, mock_request):
        self.assertRaises(
            Http404,
            lambda: self.call_view(
                mock_request,
                "cohorted_topic",
                self.student,
                self.student_cohort.id,
                thread_group_id=self.moderator_cohort.id
            )
        )

    def test_moderator_non_cohorted(self, mock_request):
        resp = self.call_view(mock_request, "non_cohorted_topic", self.moderator, self.moderator_cohort.id)
        self.assertEqual(resp.status_code, 200)

    def test_moderator_same_cohort(self, mock_request):
        resp = self.call_view(
            mock_request,
            "cohorted_topic",
            self.moderator,
            self.moderator_cohort.id,
            thread_group_id=self.moderator_cohort.id
        )
        self.assertEqual(resp.status_code, 200)

    def test_moderator_different_cohort(self, mock_request):
        resp = self.call_view(
            mock_request,
            "cohorted_topic",
            self.moderator,
            self.moderator_cohort.id,
            thread_group_id=self.student_cohort.id
        )
        self.assertEqual(resp.status_code, 200)


@patch('lms.lib.comment_client.utils.requests.request')
class SingleThreadGroupIdTestCase(CohortedContentTestCase, CohortedTopicGroupIdTestMixin):
    cs_endpoint = "/threads"

    def call_view(self, mock_request, commentable_id, user, group_id, pass_group_id=True, is_ajax=False):
        mock_request.side_effect = make_mock_request_impl("dummy context", group_id=self.student_cohort.id)

        request_data = {}
        if pass_group_id:
            request_data["group_id"] = group_id
        headers = {}
        if is_ajax:
            headers['HTTP_X_REQUESTED_WITH'] = "XMLHttpRequest"
        request = RequestFactory().get(
            "dummy_url",
            data=request_data,
            **headers
        )
        request.user = user
        mako_middleware_process_request(request)
        return views.single_thread(
            request,
            self.course.id.to_deprecated_string(),
            "dummy_discussion_id",
            "dummy_thread_id"
        )

    def test_group_info_in_html_response(self, mock_request):
        response = self.call_view(
            mock_request,
            "cohorted_topic",
            self.student,
            self.student_cohort.id,
            is_ajax=False
        )
        self._assert_html_response_contains_group_info(response)

    def test_group_info_in_ajax_response(self, mock_request):
        response = self.call_view(
            mock_request,
            "cohorted_topic",
            self.student,
            self.student_cohort.id,
            is_ajax=True
        )
        self._assert_json_response_contains_group_info(
            response, lambda d: d['content']
        )


@patch('lms.lib.comment_client.utils.requests.request')
class InlineDiscussionGroupIdTestCase(
        CohortedContentTestCase,
        CohortedTopicGroupIdTestMixin,
        NonCohortedTopicGroupIdTestMixin
):
    cs_endpoint = "/threads"

    def call_view(self, mock_request, commentable_id, user, group_id, pass_group_id=True):
        kwargs = {}
        if group_id:
            # avoid causing a server error when the LMS chokes attempting
            # to find a group name for the group_id, when we're testing with
            # an invalid one.
            try:
                CourseUserGroup.objects.get(id=group_id)
                kwargs['group_id'] = group_id
            except CourseUserGroup.DoesNotExist:
                pass
        mock_request.side_effect = make_mock_request_impl("dummy content", **kwargs)

        request_data = {}
        if pass_group_id:
            request_data["group_id"] = group_id
        request = RequestFactory().get(
            "dummy_url",
            data=request_data
        )
        request.user = user
        return views.inline_discussion(
            request,
            self.course.id.to_deprecated_string(),
            commentable_id
        )

    def test_group_info_in_ajax_response(self, mock_request):
        response = self.call_view(
            mock_request,
            "cohorted_topic",
            self.student,
            self.student_cohort.id
        )
        self._assert_json_response_contains_group_info(
            response, lambda d: d['discussion_data'][0]
        )


@patch('lms.lib.comment_client.utils.requests.request')
class ForumFormDiscussionGroupIdTestCase(CohortedContentTestCase, CohortedTopicGroupIdTestMixin):
    cs_endpoint = "/threads"

    def call_view(self, mock_request, commentable_id, user, group_id, pass_group_id=True, is_ajax=False):
        kwargs = {}
        if group_id:
            kwargs['group_id'] = group_id
        mock_request.side_effect = make_mock_request_impl("dummy content", **kwargs)

        request_data = {}
        if pass_group_id:
            request_data["group_id"] = group_id
        headers = {}
        if is_ajax:
            headers['HTTP_X_REQUESTED_WITH'] = "XMLHttpRequest"
        request = RequestFactory().get(
            "dummy_url",
            data=request_data,
            **headers
        )
        request.user = user
        mako_middleware_process_request(request)
        return views.forum_form_discussion(
            request,
            self.course.id.to_deprecated_string()
        )

    def test_group_info_in_html_response(self, mock_request):
        response = self.call_view(
            mock_request,
            "cohorted_topic",
            self.student,
            self.student_cohort.id
        )
        self._assert_html_response_contains_group_info(response)

    def test_group_info_in_ajax_response(self, mock_request):
        response = self.call_view(
            mock_request,
            "cohorted_topic",
            self.student,
            self.student_cohort.id,
            is_ajax=True
        )
        self._assert_json_response_contains_group_info(
            response, lambda d: d['discussion_data'][0]
        )


@patch('lms.lib.comment_client.utils.requests.request')
class UserProfileDiscussionGroupIdTestCase(CohortedContentTestCase, CohortedTopicGroupIdTestMixin):
    cs_endpoint = "/active_threads"

    def call_view_for_profiled_user(
            self, mock_request, requesting_user, profiled_user, group_id, pass_group_id, is_ajax=False
    ):
        """
        Calls "user_profile" view method on behalf of "requesting_user" to get information about
        the user "profiled_user".
        """
        kwargs = {}
        if group_id:
            kwargs['group_id'] = group_id
        mock_request.side_effect = make_mock_request_impl("dummy content", **kwargs)

        request_data = {}
        if pass_group_id:
            request_data["group_id"] = group_id
        headers = {}
        if is_ajax:
            headers['HTTP_X_REQUESTED_WITH'] = "XMLHttpRequest"
        request = RequestFactory().get(
            "dummy_url",
            data=request_data,
            **headers
        )
        request.user = requesting_user
        mako_middleware_process_request(request)
        return views.user_profile(
            request,
            self.course.id.to_deprecated_string(),
            profiled_user.id
        )

    def call_view(self, mock_request, _commentable_id, user, group_id, pass_group_id=True, is_ajax=False):
        return self.call_view_for_profiled_user(
            mock_request, user, user, group_id, pass_group_id=pass_group_id, is_ajax=is_ajax
        )

    def test_group_info_in_html_response(self, mock_request):
        response = self.call_view(
            mock_request,
            "cohorted_topic",
            self.student,
            self.student_cohort.id,
            is_ajax=False
        )
        self._assert_html_response_contains_group_info(response)

    def test_group_info_in_ajax_response(self, mock_request):
        response = self.call_view(
            mock_request,
            "cohorted_topic",
            self.student,
            self.student_cohort.id,
            is_ajax=True
        )
        self._assert_json_response_contains_group_info(
            response, lambda d: d['discussion_data'][0]
        )

    def _test_group_id_passed_to_user_profile(
            self, mock_request, expect_group_id_in_request, requesting_user, profiled_user, group_id, pass_group_id
    ):
        """
        Helper method for testing whether or not group_id was passed to the user_profile request.
        """

        def get_params_from_user_info_call(for_specific_course):
            """
            Returns the request parameters for the user info call with either course_id specified or not,
            depending on value of 'for_specific_course'.
            """
            # There will be 3 calls from user_profile. One has the cs_endpoint "active_threads", and it is already
            # tested. The other 2 calls are for user info; one of those calls is for general information about the user,
            # and it does not specify a course_id. The other call does specify a course_id, and if the caller did not
            # have discussion moderator privileges, it should also contain a group_id.
            for r_call in mock_request.call_args_list:
                if not r_call[0][1].endswith(self.cs_endpoint):
                    params = r_call[1]["params"]
                    has_course_id = "course_id" in params
                    if (for_specific_course and has_course_id) or (not for_specific_course and not has_course_id):
                        return params
            self.assertTrue(
                False,
                "Did not find appropriate user_profile call for 'for_specific_course'=" + for_specific_course
            )

        mock_request.reset_mock()
        self.call_view_for_profiled_user(
            mock_request,
            requesting_user,
            profiled_user,
            group_id,
            pass_group_id=pass_group_id,
            is_ajax=False
        )
        # Should never have a group_id if course_id was not included in the request.
        params_without_course_id = get_params_from_user_info_call(False)
        self.assertNotIn("group_id", params_without_course_id)

        params_with_course_id = get_params_from_user_info_call(True)
        if expect_group_id_in_request:
            self.assertIn("group_id", params_with_course_id)
            self.assertEqual(group_id, params_with_course_id["group_id"])
        else:
            self.assertNotIn("group_id", params_with_course_id)

    def test_group_id_passed_to_user_profile_student(self, mock_request):
        """
        Test that the group id is always included when requesting user profile information for a particular
        course if the requester does not have discussion moderation privileges.
        """
        def verify_group_id_always_present(profiled_user, pass_group_id):
            """
            Helper method to verify that group_id is always present for student in course
            (non-privileged user).
            """
            self._test_group_id_passed_to_user_profile(
                mock_request, True, self.student, profiled_user, self.student_cohort.id, pass_group_id
            )

        # In all these test cases, the requesting_user is the student (non-privileged user).
        # The profile returned on behalf of the student is for the profiled_user.
        verify_group_id_always_present(profiled_user=self.student, pass_group_id=True)
        verify_group_id_always_present(profiled_user=self.student, pass_group_id=False)
        verify_group_id_always_present(profiled_user=self.moderator, pass_group_id=True)
        verify_group_id_always_present(profiled_user=self.moderator, pass_group_id=False)

    def test_group_id_user_profile_moderator(self, mock_request):
        """
        Test that the group id is only included when a privileged user requests user profile information for a
        particular course and user if the group_id is explicitly passed in.
        """
        def verify_group_id_present(profiled_user, pass_group_id, requested_cohort=self.moderator_cohort):
            """
            Helper method to verify that group_id is present.
            """
            self._test_group_id_passed_to_user_profile(
                mock_request, True, self.moderator, profiled_user, requested_cohort.id, pass_group_id
            )

        def verify_group_id_not_present(profiled_user, pass_group_id, requested_cohort=self.moderator_cohort):
            """
            Helper method to verify that group_id is not present.
            """
            self._test_group_id_passed_to_user_profile(
                mock_request, False, self.moderator, profiled_user, requested_cohort.id, pass_group_id
            )

        # In all these test cases, the requesting_user is the moderator (privileged user).

        # If the group_id is explicitly passed, it will be present in the request.
        verify_group_id_present(profiled_user=self.student, pass_group_id=True)
        verify_group_id_present(profiled_user=self.moderator, pass_group_id=True)
        verify_group_id_present(
            profiled_user=self.student, pass_group_id=True, requested_cohort=self.student_cohort
        )

        # If the group_id is not explicitly passed, it will not be present because the requesting_user
        # has discussion moderator privileges.
        verify_group_id_not_present(profiled_user=self.student, pass_group_id=False)
        verify_group_id_not_present(profiled_user=self.moderator, pass_group_id=False)


@patch('lms.lib.comment_client.utils.requests.request')
class FollowedThreadsDiscussionGroupIdTestCase(CohortedContentTestCase, CohortedTopicGroupIdTestMixin):
    cs_endpoint = "/subscribed_threads"

    def call_view(self, mock_request, commentable_id, user, group_id, pass_group_id=True):
        kwargs = {}
        if group_id:
            kwargs['group_id'] = group_id
        mock_request.side_effect = make_mock_request_impl("dummy content", **kwargs)

        request_data = {}
        if pass_group_id:
            request_data["group_id"] = group_id
        request = RequestFactory().get(
            "dummy_url",
            data=request_data,
            HTTP_X_REQUESTED_WITH="XMLHttpRequest"
        )
        request.user = user
        return views.followed_threads(
            request,
            self.course.id.to_deprecated_string(),
            user.id
        )

    def test_group_info_in_ajax_response(self, mock_request):
        response = self.call_view(
            mock_request,
            "cohorted_topic",
            self.student,
            self.student_cohort.id
        )
        self._assert_json_response_contains_group_info(
            response, lambda d: d['discussion_data'][0]
        )


@override_settings(MODULESTORE=TEST_DATA_MONGO_MODULESTORE)
class InlineDiscussionTestCase(ModuleStoreTestCase):
    def setUp(self):
        self.course = CourseFactory.create(org="TestX", number="101", display_name="Test Course")
        self.student = UserFactory.create()
        CourseEnrollmentFactory(user=self.student, course_id=self.course.id)
        self.discussion1 = ItemFactory.create(
            parent_location=self.course.location,
            category="discussion",
            discussion_id="discussion1",
            display_name='Discussion1',
            discussion_category="Chapter",
            discussion_target="Discussion1"
        )

    @patch('lms.lib.comment_client.utils.requests.request')
    def test_courseware_data(self, mock_request):
        request = RequestFactory().get("dummy_url")
        request.user = self.student
        mock_request.side_effect = make_mock_request_impl("dummy content", commentable_id=self.discussion1.discussion_id)

        response = views.inline_discussion(request, self.course.id.to_deprecated_string(), "dummy_discussion_id")
        self.assertEqual(response.status_code, 200)
        response_data = json.loads(response.content)
        expected_courseware_url = '/courses/TestX/101/Test_Course/jump_to/i4x://TestX/101/discussion/Discussion1'
        expected_courseware_title = 'Chapter / Discussion1'
        self.assertEqual(response_data['discussion_data'][0]['courseware_url'], expected_courseware_url)
        self.assertEqual(response_data["discussion_data"][0]["courseware_title"], expected_courseware_title)


@override_settings(MODULESTORE=TEST_DATA_MONGO_MODULESTORE)
@patch('requests.request')
class UserProfileTestCase(ModuleStoreTestCase):

    TEST_THREAD_TEXT = 'userprofile-test-text'
    TEST_THREAD_ID = 'userprofile-test-thread-id'

    def setUp(self):
        self.course = CourseFactory.create()
        self.student = UserFactory.create()
        self.profiled_user = UserFactory.create()
        CourseEnrollmentFactory.create(user=self.student, course_id=self.course.id)

    def get_response(self, mock_request, params, **headers):
        mock_request.side_effect = make_mock_request_impl(self.TEST_THREAD_TEXT, self.TEST_THREAD_ID)
        request = RequestFactory().get("dummy_url", data=params, **headers)
        request.user = self.student

        mako_middleware_process_request(request)
        response = views.user_profile(
            request,
            self.course.id.to_deprecated_string(),
            self.profiled_user.id
        )
        mock_request.assert_any_call(
            "get",
            StringEndsWithMatcher('/users/{}/active_threads'.format(self.profiled_user.id)),
            data=None,
            params=PartialDictMatcher({
                "course_id": self.course.id.to_deprecated_string(),
                "page": params.get("page", 1),
                "per_page": views.THREADS_PER_PAGE
            }),
            headers=ANY,
            timeout=ANY
        )
        return response

    def check_html(self, mock_request, **params):
        response = self.get_response(mock_request, params)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response['Content-Type'], 'text/html; charset=utf-8')
        html = response.content
        self.assertRegexpMatches(html, r'data-page="1"')
        self.assertRegexpMatches(html, r'data-num-pages="1"')
        self.assertRegexpMatches(html, r'<span>1</span> discussion started')
        self.assertRegexpMatches(html, r'<span>2</span> comments')
        self.assertRegexpMatches(html, r'&#34;id&#34;: &#34;{}&#34;'.format(self.TEST_THREAD_ID))
        self.assertRegexpMatches(html, r'&#34;title&#34;: &#34;{}&#34;'.format(self.TEST_THREAD_TEXT))
        self.assertRegexpMatches(html, r'&#34;body&#34;: &#34;{}&#34;'.format(self.TEST_THREAD_TEXT))
        self.assertRegexpMatches(html, r'&#34;username&#34;: &#34;{}&#34;'.format(self.student.username))

    def check_ajax(self, mock_request, **params):
        response = self.get_response(mock_request, params, HTTP_X_REQUESTED_WITH="XMLHttpRequest")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response['Content-Type'], 'application/json; charset=utf-8')
        response_data = json.loads(response.content)
        self.assertEqual(
            sorted(response_data.keys()),
            ["annotated_content_info", "discussion_data", "num_pages", "page"]
        )
        self.assertEqual(len(response_data['discussion_data']), 1)
        self.assertEqual(response_data["page"], 1)
        self.assertEqual(response_data["num_pages"], 1)
        self.assertEqual(response_data['discussion_data'][0]['id'], self.TEST_THREAD_ID)
        self.assertEqual(response_data['discussion_data'][0]['title'], self.TEST_THREAD_TEXT)
        self.assertEqual(response_data['discussion_data'][0]['body'], self.TEST_THREAD_TEXT)

    def test_html(self, mock_request):
        self.check_html(mock_request)

    def test_html_p2(self, mock_request):
        self.check_html(mock_request, page="2")

    def test_ajax(self, mock_request):
        self.check_ajax(mock_request)

    def test_ajax_p2(self, mock_request):
        self.check_ajax(mock_request, page="2")

    def test_404_profiled_user(self, mock_request):
        request = RequestFactory().get("dummy_url")
        request.user = self.student
        with self.assertRaises(Http404):
            response = views.user_profile(
                request,
                self.course.id.to_deprecated_string(),
                -999
            )

    def test_404_course(self, mock_request):
        request = RequestFactory().get("dummy_url")
        request.user = self.student
        with self.assertRaises(Http404):
            response = views.user_profile(
                request,
                "non/existent/course",
                self.profiled_user.id
            )

    def test_post(self, mock_request):
        mock_request.side_effect = make_mock_request_impl(self.TEST_THREAD_TEXT, self.TEST_THREAD_ID)
        request = RequestFactory().post("dummy_url")
        request.user = self.student
        response = views.user_profile(
            request,
            self.course.id.to_deprecated_string(),
            self.profiled_user.id
        )
        self.assertEqual(response.status_code, 405)


@override_settings(MODULESTORE=TEST_DATA_MONGO_MODULESTORE)
@patch('requests.request')
class CommentsServiceRequestHeadersTestCase(UrlResetMixin, ModuleStoreTestCase):
    @patch.dict("django.conf.settings.FEATURES", {"ENABLE_DISCUSSION_SERVICE": True})
    def setUp(self):
        username = "foo"
        password = "bar"

        # Invoke UrlResetMixin
        super(CommentsServiceRequestHeadersTestCase, self).setUp()
        self.course = CourseFactory.create()
        self.student = UserFactory.create(username=username, password=password)
        CourseEnrollmentFactory.create(user=self.student, course_id=self.course.id)
        self.assertTrue(
            self.client.login(username=username, password=password)
        )

    def assert_all_calls_have_header(self, mock_request, key, value):
        expected = call(
            ANY,  # method
            ANY,  # url
            data=ANY,
            params=ANY,
            headers=PartialDictMatcher({key: value}),
            timeout=ANY
        )
        for actual in mock_request.call_args_list:
            self.assertEqual(expected, actual)

    def test_accept_language(self, mock_request):
        lang = "eo"
        text = "dummy content"
        thread_id = "test_thread_id"
        mock_request.side_effect = make_mock_request_impl(text, thread_id)

        self.client.get(
            reverse(
                "django_comment_client.forum.views.single_thread",
                kwargs={
                    "course_id": self.course.id.to_deprecated_string(),
                    "discussion_id": "dummy",
                    "thread_id": thread_id,
                }
            ),
            HTTP_ACCEPT_LANGUAGE=lang,
        )
        self.assert_all_calls_have_header(mock_request, "Accept-Language", lang)

    @override_settings(COMMENTS_SERVICE_KEY="test_api_key")
    def test_api_key(self, mock_request):
        mock_request.side_effect = make_mock_request_impl("dummy", "dummy")

        self.client.get(
            reverse(
                "django_comment_client.forum.views.forum_form_discussion",
                kwargs={"course_id": self.course.id.to_deprecated_string()}
            ),
        )
        self.assert_all_calls_have_header(mock_request, "X-Edx-Api-Key", "test_api_key")


@override_settings(MODULESTORE=TEST_DATA_MONGO_MODULESTORE)
class InlineDiscussionUnicodeTestCase(ModuleStoreTestCase, UnicodeTestMixin):
    def setUp(self):
        self.course = CourseFactory.create()
        self.student = UserFactory.create()
        CourseEnrollmentFactory(user=self.student, course_id=self.course.id)

    @patch('lms.lib.comment_client.utils.requests.request')
    def _test_unicode_data(self, text, mock_request):
        mock_request.side_effect = make_mock_request_impl(text)
        request = RequestFactory().get("dummy_url")
        request.user = self.student

        response = views.inline_discussion(request, self.course.id.to_deprecated_string(), "dummy_discussion_id")
        self.assertEqual(response.status_code, 200)
        response_data = json.loads(response.content)
        self.assertEqual(response_data["discussion_data"][0]["title"], text)
        self.assertEqual(response_data["discussion_data"][0]["body"], text)


@override_settings(MODULESTORE=TEST_DATA_MONGO_MODULESTORE)
class ForumFormDiscussionUnicodeTestCase(ModuleStoreTestCase, UnicodeTestMixin):
    def setUp(self):
        self.course = CourseFactory.create()
        self.student = UserFactory.create()
        CourseEnrollmentFactory(user=self.student, course_id=self.course.id)

    @patch('lms.lib.comment_client.utils.requests.request')
    def _test_unicode_data(self, text, mock_request):
        mock_request.side_effect = make_mock_request_impl(text)
        request = RequestFactory().get("dummy_url")
        request.user = self.student
        request.META["HTTP_X_REQUESTED_WITH"] = "XMLHttpRequest"  # so request.is_ajax() == True

        response = views.forum_form_discussion(request, self.course.id.to_deprecated_string())
        self.assertEqual(response.status_code, 200)
        response_data = json.loads(response.content)
        self.assertEqual(response_data["discussion_data"][0]["title"], text)
        self.assertEqual(response_data["discussion_data"][0]["body"], text)


@override_settings(MODULESTORE=TEST_DATA_MONGO_MODULESTORE)
class ForumDiscussionSearchUnicodeTestCase(ModuleStoreTestCase, UnicodeTestMixin):
    def setUp(self):
        self.course = CourseFactory.create()
        self.student = UserFactory.create()
        CourseEnrollmentFactory(user=self.student, course_id=self.course.id)

    @patch('lms.lib.comment_client.utils.requests.request')
    def _test_unicode_data(self, text, mock_request):
        mock_request.side_effect = make_mock_request_impl(text)
        data = {
            "ajax": 1,
            "text": text,
        }
        request = RequestFactory().get("dummy_url", data)
        request.user = self.student
        request.META["HTTP_X_REQUESTED_WITH"] = "XMLHttpRequest"  # so request.is_ajax() == True

        response = views.forum_form_discussion(request, self.course.id.to_deprecated_string())
        self.assertEqual(response.status_code, 200)
        response_data = json.loads(response.content)
        self.assertEqual(response_data["discussion_data"][0]["title"], text)
        self.assertEqual(response_data["discussion_data"][0]["body"], text)


@override_settings(MODULESTORE=TEST_DATA_MONGO_MODULESTORE)
class SingleThreadUnicodeTestCase(ModuleStoreTestCase, UnicodeTestMixin):
    def setUp(self):
        self.course = CourseFactory.create()
        self.student = UserFactory.create()
        CourseEnrollmentFactory(user=self.student, course_id=self.course.id)

    @patch('lms.lib.comment_client.utils.requests.request')
    def _test_unicode_data(self, text, mock_request):
        thread_id = "test_thread_id"
        mock_request.side_effect = make_mock_request_impl(text, thread_id)
        request = RequestFactory().get("dummy_url")
        request.user = self.student
        request.META["HTTP_X_REQUESTED_WITH"] = "XMLHttpRequest"  # so request.is_ajax() == True

        response = views.single_thread(request, self.course.id.to_deprecated_string(), "dummy_discussion_id", thread_id)
        self.assertEqual(response.status_code, 200)
        response_data = json.loads(response.content)
        self.assertEqual(response_data["content"]["title"], text)
        self.assertEqual(response_data["content"]["body"], text)


@override_settings(MODULESTORE=TEST_DATA_MONGO_MODULESTORE)
class UserProfileUnicodeTestCase(ModuleStoreTestCase, UnicodeTestMixin):
    def setUp(self):
        self.course = CourseFactory.create()
        self.student = UserFactory.create()
        CourseEnrollmentFactory(user=self.student, course_id=self.course.id)

    @patch('lms.lib.comment_client.utils.requests.request')
    def _test_unicode_data(self, text, mock_request):
        mock_request.side_effect = make_mock_request_impl(text)
        request = RequestFactory().get("dummy_url")
        request.user = self.student
        request.META["HTTP_X_REQUESTED_WITH"] = "XMLHttpRequest"  # so request.is_ajax() == True

        response = views.user_profile(request, self.course.id.to_deprecated_string(), str(self.student.id))
        self.assertEqual(response.status_code, 200)
        response_data = json.loads(response.content)
        self.assertEqual(response_data["discussion_data"][0]["title"], text)
        self.assertEqual(response_data["discussion_data"][0]["body"], text)


@override_settings(MODULESTORE=TEST_DATA_MONGO_MODULESTORE)
class FollowedThreadsUnicodeTestCase(ModuleStoreTestCase, UnicodeTestMixin):
    def setUp(self):
        self.course = CourseFactory.create()
        self.student = UserFactory.create()
        CourseEnrollmentFactory(user=self.student, course_id=self.course.id)

    @patch('lms.lib.comment_client.utils.requests.request')
    def _test_unicode_data(self, text, mock_request):
        mock_request.side_effect = make_mock_request_impl(text)
        request = RequestFactory().get("dummy_url")
        request.user = self.student
        request.META["HTTP_X_REQUESTED_WITH"] = "XMLHttpRequest"  # so request.is_ajax() == True

        response = views.followed_threads(request, self.course.id.to_deprecated_string(), str(self.student.id))
        self.assertEqual(response.status_code, 200)
        response_data = json.loads(response.content)
        self.assertEqual(response_data["discussion_data"][0]["title"], text)
        self.assertEqual(response_data["discussion_data"][0]["body"], text)


@override_settings(MODULESTORE=TEST_DATA_MONGO_MODULESTORE)
class EnrollmentTestCase(ModuleStoreTestCase):
    """
    Tests for the behavior of views depending on if the student is enrolled
    in the course
    """

    @patch.dict("django.conf.settings.FEATURES", {"ENABLE_DISCUSSION_SERVICE": True})
    def setUp(self):
        super(EnrollmentTestCase, self).setUp()
        self.course = CourseFactory.create()
        self.student = UserFactory.create()

    @patch.dict("django.conf.settings.FEATURES", {"ENABLE_DISCUSSION_SERVICE": True})
    @patch('lms.lib.comment_client.utils.requests.request')
    def test_unenrolled(self, mock_request):
        mock_request.side_effect = make_mock_request_impl('dummy')
        request = RequestFactory().get('dummy_url')
        request.user = self.student
        with self.assertRaises(UserNotEnrolled):
            views.forum_form_discussion(request, course_id=self.course.id.to_deprecated_string())
