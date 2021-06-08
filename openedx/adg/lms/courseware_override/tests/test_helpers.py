"""
Tests for helpers.py file of courseware_override
"""
import mock
import pytest

from common.djangoapps.student.tests.factories import CourseEnrollmentFactory, UserFactory
from openedx.adg.lms.applications.tests.factories import MultilingualCourseFactory
from openedx.adg.lms.courseware_override.helpers import get_extra_course_about_context, get_language_names_from_codes
from openedx.core.djangoapps.content.course_overviews.tests.factories import CourseOverviewFactory

from .constants import EFFORT


@pytest.mark.django_db
@pytest.fixture(name='users')
def user_fixture(request):
    """
    Create test users

    Returns:
        list: A list of User objects as specified
    """
    users = UserFactory.create_batch(request.param)
    return users


@pytest.mark.django_db
@pytest.mark.parametrize(
    'language_codes, language_names', [(['en'], ['English']), (['ar', 'en'], ['Arabic', 'English'])]
)
def test_get_language_name_from_codes(language_codes, language_names):
    """
    Tests if the correct language names are being returned, with their respective course_ids
    """
    language_codes_with_course_ids = []
    expected_output = []

    for language_code, language_name in zip(language_codes, language_names):
        course = CourseOverviewFactory(language=language_code)
        language_codes_with_course_ids.append((course.id, language_code))
        expected_output.append((course.id, language_name))

    assert get_language_names_from_codes(language_codes_with_course_ids) == expected_output


@pytest.mark.django_db
@mock.patch('openedx.adg.lms.courseware_override.helpers.is_testing_environment')
@mock.patch('openedx.adg.lms.courseware_override.helpers.get_language_names_from_codes')
def test_get_extra_course_about_context(mock_get_lang_names, mock_testing_env):
    """
    Test if the context is being returned correctly by the get_extra_course_about_context function
    """
    user = UserFactory()
    course = CourseOverviewFactory(self_paced=True, effort=EFFORT, language='en')
    CourseEnrollmentFactory(user=user, course=course)
    MultilingualCourseFactory(course=course)

    course_languages_with_ids = [(course.id, 'English')]

    mock_get_lang_names.return_value = course_languages_with_ids
    mock_testing_env.return_value = False

    expected_context = {
        'course_languages': course_languages_with_ids,
        'total_enrollments': 1,
        'self_paced': True,
        'effort': EFFORT,
    }

    assert get_extra_course_about_context(None, course) == expected_context
