"""
Tests for all functionality related to UserApplicationADGAdmin
"""
# pylint: disable=protected-access

import mock
import pytest
from django.utils.html import format_html

from common.djangoapps.student.tests.factories import UserFactory
from openedx.adg.constants import MONTH_DAY_YEAR_FORMAT
from openedx.adg.lms.applications.admin import (
    EducationInline,
    UserApplicationADGAdmin,
    WorkExperienceInline,
    adg_admin_site
)
from openedx.adg.lms.applications.constants import (
    ACCEPTED_APPLICATIONS_TITLE,
    ALL_APPLICATIONS_TITLE,
    APPLICANT_INFO_FIELDSET_TITLE,
    APPLYING_TO,
    COVER_LETTER_FILE,
    COVER_LETTER_FILE_DISPLAY,
    COVER_LETTER_ONLY,
    COVER_LETTER_TEXT,
    DATE_OF_BIRTH,
    DAY_MONTH_YEAR_FORMAT,
    EMAIL,
    EMAIL_ADDRESS_HTML,
    GENDER,
    GENDER_MAP,
    IS_SAUDI_NATIONAL,
    LINKED_IN_PROFILE,
    LINKED_IN_PROFILE_HTML,
    LOCATION,
    OPEN_APPLICATIONS_TITLE,
    ORGANIZATION,
    PHONE_NUMBER,
    PREREQUISITES,
    RESUME,
    RESUME_AND_COVER_LETTER,
    RESUME_DISPLAY,
    RESUME_ONLY,
    SCORES,
    STATUS_PARAM,
    WAITLISTED_APPLICATIONS_TITLE,
    CourseScore
)
from openedx.adg.lms.applications.models import UserApplication
from openedx.adg.lms.applications.tests.constants import (
    ALL_FIELDSETS,
    FIELDSETS_WITHOUT_RESUME_OR_COVER_LETTER,
    LINKED_IN_URL,
    NOTE,
    TEST_COVER_LETTER_FILE,
    TEST_COVER_LETTER_TEXT,
    TEST_RESUME
)
from openedx.adg.lms.applications.tests.factories import ApplicationHubFactory, WorkExperienceFactory
from openedx.adg.lms.registration_extension.tests.factories import ExtendedUserProfileFactory


@mock.patch('openedx.adg.lms.applications.admin.UserApplication.submitted_applications')
def test_get_queryset(mock_submitted_applications_manager):
    """
    Test that `get_queryset()` method calls the submitted_applications manager from UserApplication.
    """
    UserApplicationADGAdmin.get_queryset('self', 'request')

    assert mock_submitted_applications_manager.called_once()


@pytest.mark.django_db
def test_applicant_name(user_application):
    """
    Test that `applicant_name()` field method returns the user's full name from user
    profile.
    """
    expected_name = user_application.user.profile.name
    actual_name = UserApplicationADGAdmin.applicant_name('self', user_application)

    assert expected_name == actual_name


@pytest.mark.django_db
def test_date_received(user_application, current_date):
    """
    Test that `date_received()` field method returns submission date of the application in the correct format
    (MM/DD/YYYY).
    """
    application_hub = ApplicationHubFactory()
    application_hub.user = user_application.user

    application_hub.submission_date = current_date

    expected_date = current_date.strftime(MONTH_DAY_YEAR_FORMAT)
    actual_date = UserApplicationADGAdmin.date_received('self', user_application)

    assert expected_date == actual_date


@pytest.mark.parametrize(
    'status, expected_title', [
        (None, ALL_APPLICATIONS_TITLE),
        (UserApplication.OPEN, OPEN_APPLICATIONS_TITLE),
        (UserApplication.WAITLIST, WAITLISTED_APPLICATIONS_TITLE),
        (UserApplication.ACCEPTED, ACCEPTED_APPLICATIONS_TITLE)
    ], ids=['all_applications', 'open_applications', 'waitlisted_applications', 'accepted_applications']
)
@pytest.mark.django_db
@mock.patch('openedx.adg.lms.applications.admin.admin.ModelAdmin.changelist_view')
def test_changelist_view(
    mock_changelist_view, request, user_application, user_application_adg_admin_instance, status, expected_title
):
    """
    Test that the correct title is passed in context for the application listing page view, based on the status filter
    selected by the admin.
    """
    request.GET = {}
    if status:
        request.GET[STATUS_PARAM] = status

    UserApplicationADGAdmin.changelist_view(user_application_adg_admin_instance, request)

    expected_context = {'title': expected_title}
    mock_changelist_view.assert_called_once_with(request, extra_context=expected_context)


@pytest.mark.parametrize(
    'request_method, status, note', [
        ('POST', None, NOTE),
        ('POST', UserApplication.WAITLIST, NOTE),
        ('GET', None, '')
    ],
    ids=['post_without_status', 'post_with_status', 'get']
)
@pytest.mark.django_db
@mock.patch('openedx.adg.lms.applications.admin.admin.ModelAdmin.changeform_view')
@mock.patch('openedx.adg.lms.applications.admin.get_extra_context_for_application_review_page')
@mock.patch('openedx.adg.lms.applications.admin.UserApplicationADGAdmin._save_application_review_info')
def test_changeform_view(
    mock_save_application_review_info,
    mock_get_extra_context_for_application_review_page,
    mock_changeform_view,
    request,
    user_application,
    user_application_adg_admin_instance,
    request_method,
    status,
    note
):
    """
    Test the overridden changeform_view.

    Test Case 1: post_without_status
        Test that if a POST request is made with an internal note but without status, the application should not be
        saved and admin should be shown the application review page with the right context.

    Test Case 2: post_with_status
        Test that if a POST request is made with internal note and status, the application should be updated and saved.

    Test Case 3: get
        Test that if a GET request is made, the right context should be rendered for the application review page.
    """
    application_id = user_application.id

    expected_context = {'test_key': 'test_value'}
    mock_get_extra_context_for_application_review_page.return_value = expected_context

    request.method = request_method
    if request.method == 'POST':
        request.POST = {'internal_note': note}
        if status:
            request.POST['status'] = status
            UserApplicationADGAdmin.changeform_view(user_application_adg_admin_instance, request, application_id)

            mock_save_application_review_info.assert_called_once_with(user_application, request, note)
            mock_changeform_view.assert_called_once_with(request, application_id, extra_context=None)
        else:
            UserApplicationADGAdmin.changeform_view(user_application_adg_admin_instance, request, application_id)

            mock_save_application_review_info.assert_not_called()
            mock_get_extra_context_for_application_review_page.assert_called_once_with(user_application)
            mock_changeform_view.assert_called_once_with(request, application_id, extra_context=expected_context)
    elif request.method == 'GET':
        UserApplicationADGAdmin.changeform_view(user_application_adg_admin_instance, request, application_id)

        mock_get_extra_context_for_application_review_page.assert_called_once_with(user_application)
        mock_changeform_view.assert_called_once_with(request, application_id, extra_context=expected_context)


@pytest.mark.django_db
def test_save_application_review_info(request, user_application):
    """
    Test that application review information is successfully saved.
    """
    request.user = UserFactory()
    request.POST = {'status': UserApplication.ACCEPTED}

    UserApplicationADGAdmin._save_application_review_info('self', user_application, request, NOTE)

    updated_application = UserApplication.objects.get(id=user_application.id)

    assert updated_application.status == UserApplication.ACCEPTED
    assert updated_application.internal_admin_note == NOTE
    assert updated_application.reviewed_by == request.user


@pytest.mark.django_db
def test_email(user_application):
    """
    Test that the `email` field method returns safe HTML containing the correct email address of the applicant.
    """
    expected_email_address = format_html(EMAIL_ADDRESS_HTML, email_address=user_application.user.email)
    actual_email_address = UserApplicationADGAdmin.email('self', user_application)

    assert expected_email_address == actual_email_address


@pytest.mark.parametrize(
    'country, expected_location', [
        (None, 'Test_city'),
        ('Test_country', 'Test_city, Test_country')
    ]
)
@pytest.mark.django_db
def test_location(user_application, country, expected_location):
    """
    Test that the `location` field method returns city and conditionally, country of the applicant.
    """
    user_profile = user_application.user.profile
    user_profile.city = 'Test_city'
    user_profile.country = country

    actual_location = UserApplicationADGAdmin.location('self', user_application)

    assert expected_location == actual_location


@pytest.mark.django_db
def test_linked_in_profile(user_application):
    """
    Test that the `linked_in_profile` field method returns safe HTML containing link of the applicant's LinkedIn profile
    """
    user_application.linkedin_url = LINKED_IN_URL

    expected_linked_in_profile = format_html(LINKED_IN_PROFILE_HTML, url='Test LinkedIn URL')
    actual_linked_in_profile = UserApplicationADGAdmin.linked_in_profile('self', user_application)

    assert expected_linked_in_profile == actual_linked_in_profile


@pytest.mark.parametrize(
    'saudi_national, expected_answer', [
        (True, 'Yes'),
        (False, 'No')
    ]
)
@pytest.mark.django_db
def test_is_saudi_national(user_application, saudi_national, expected_answer):
    """
    Test that if the applicant is a Saudi national, `is_saudi_national` field method should return 'Yes'; 'No' otherwise
    """
    extended_profile = ExtendedUserProfileFactory()
    extended_profile.user = user_application.user
    extended_profile.saudi_national = saudi_national

    actual_answer = UserApplicationADGAdmin.is_saudi_national('self', user_application)

    assert expected_answer == actual_answer


@pytest.mark.parametrize(
    'gender_choice, expected_gender', [
        (choice, gender) for choice, gender in GENDER_MAP.items()  # pylint: disable=unnecessary-comprehension
    ], ids=['male', 'female', 'other']
)
@pytest.mark.django_db
def test_gender(user_application, gender_choice, expected_gender):
    """
    Test that the `gender` field method returns the gender chosen by the applicant.
    """
    user_profile = user_application.user.profile
    user_profile.gender = gender_choice

    actual_gender = UserApplicationADGAdmin.gender('self', user_application)

    assert expected_gender == actual_gender


@pytest.mark.django_db
def test_phone_number(user_application):
    """
    Test that the `phone_number` field method returns the phone number of the applicant.
    """
    user_profile = user_application.user.profile
    user_profile.phone_number = 'Test Phone Number'

    expected_phone_number = user_profile.phone_number
    actual_phone_number = UserApplicationADGAdmin.phone_number('self', user_application)

    assert expected_phone_number == actual_phone_number


@pytest.mark.django_db
def test_date_of_birth(user_application, current_date):
    """
    Test the the `date_of_birth` field method returns the birth date of the applicant in the correct format.
    """
    extended_profile = ExtendedUserProfileFactory()
    extended_profile.user = user_application.user
    extended_profile.birth_date = current_date

    expected_date_of_birth = extended_profile.birth_date.strftime(DAY_MONTH_YEAR_FORMAT)
    actual_date_of_birth = UserApplicationADGAdmin.date_of_birth('self', user_application)

    assert expected_date_of_birth == actual_date_of_birth


@pytest.mark.django_db
def test_applying_to(user_application):
    """
    Test that the `applying_to` field method returns the business line that the applicant is applying to.
    """
    expected_business_line = user_application.business_line
    actual_business_line = UserApplicationADGAdmin.applying_to('self', user_application)

    assert expected_business_line == actual_business_line


@pytest.mark.django_db
@mock.patch('openedx.adg.lms.applications.admin.get_embedded_view_html')
def test_resume_display(mock_get_embedded_view_html, user_application):
    """
    Test that `resume_display` field method gets HTML for embedded view of resume file uploaded by applicant.
    """
    user_application.resume = 'Test Resume File'
    UserApplicationADGAdmin.resume_display('self', user_application)

    mock_get_embedded_view_html.assert_called_once_with(user_application.resume)


@pytest.mark.django_db
@mock.patch('openedx.adg.lms.applications.admin.get_embedded_view_html')
def test_cover_letter_file_display(mock_get_embedded_view_html, user_application):
    """
    Test that `cover_letter_file_display` field method gets HTML for embedded view of cover letter file uploaded by
    applicant.
    """
    user_application.cover_letter_file = 'Test Cover Letter File'
    UserApplicationADGAdmin.cover_letter_file_display('self', user_application)

    mock_get_embedded_view_html.assert_called_once_with(user_application.cover_letter_file)


@pytest.mark.django_db
@mock.patch('openedx.adg.lms.applications.admin.UserApplication.prereq_course_scores', new_callable=mock.PropertyMock)
def test_prerequisites(mock_prereq_course_scores, user_application):
    """
    Test that the `prerequisites` field method returns safe and correct HTML for scores of applicant in prereq courses.
    """
    course_score_1 = CourseScore('Test Course 101', 75)
    course_score_2 = CourseScore('Test Course 102', 90)
    mock_prereq_course_scores.return_value = [course_score_1, course_score_2]

    expected_html = '<p>Test Course 101: <b>75%</b></p>' + '<p>Test Course 102: <b>90%</b></p>'
    expected_result = format_html(expected_html)
    actual_result = UserApplicationADGAdmin.prerequisites('self', user_application)

    assert expected_result == actual_result


@pytest.mark.parametrize('resume, cover_letter_file, cover_letter_text, expected_fieldsets', [
    (TEST_RESUME, None, None, ALL_FIELDSETS),
    (None, TEST_COVER_LETTER_FILE, None, ALL_FIELDSETS),
    (None, None, TEST_COVER_LETTER_TEXT, ALL_FIELDSETS),
    (None, None, None, FIELDSETS_WITHOUT_RESUME_OR_COVER_LETTER)
], ids=['with_resume', 'with_cover_letter_file', 'with_cover_letter_text', 'with_neither_resume_nor_cover_letter']
)
@pytest.mark.django_db
@mock.patch('openedx.adg.lms.applications.admin.UserApplicationADGAdmin._get_fieldset_for_scores')
@mock.patch('openedx.adg.lms.applications.admin.UserApplicationADGAdmin._get_fieldset_for_resume_cover_letter')
@mock.patch('openedx.adg.lms.applications.admin.UserApplicationADGAdmin._get_applicant_info_fieldset')
@mock.patch('openedx.adg.lms.applications.admin.UserApplicationADGAdmin._get_preliminary_info_fieldset')
def test_get_fieldsets(
    mock_get_preliminary_info_fieldset,
    mock_get_applicant_info_fieldset,
    mock_get_fieldset_for_resume_cover_letter,
    mock_get_fieldset_for_scores,
    request,
    user_application,
    user_application_adg_admin_instance,
    resume,
    cover_letter_file,
    cover_letter_text,
    expected_fieldsets
):
    """
    Test that the `get_fieldsets` method gets the fieldsets for: preliminary info, applicant info, conditionally resume
    and cover letter, and scores of applicant.

    If either resume or cover letter in any form is provided with the application, a fieldset for resume/cover letter
    should be returned. Otherwise, it should be omitted.
    """
    mock_get_preliminary_info_fieldset.return_value = ALL_FIELDSETS[0]
    mock_get_applicant_info_fieldset.return_value = ALL_FIELDSETS[1]
    mock_get_fieldset_for_resume_cover_letter.return_value = ALL_FIELDSETS[2]
    mock_get_fieldset_for_scores.return_value = ALL_FIELDSETS[3]

    user_application.resume = resume
    user_application.cover_letter_file = cover_letter_file
    user_application.cover_letter = cover_letter_text

    actual_fieldsets = UserApplicationADGAdmin.get_fieldsets(
        user_application_adg_admin_instance, request, user_application
    )

    assert expected_fieldsets == actual_fieldsets


@pytest.mark.parametrize('linkedin_url, expected_fields', [
    (LINKED_IN_URL, (EMAIL, LOCATION, LINKED_IN_PROFILE)),
    (None, (EMAIL, LOCATION))
], ids=['with_linkedIn profile', 'without_linkedIn_profile'])
@pytest.mark.django_db
def test_get_preliminary_info_fieldset(user_application, linkedin_url, expected_fields):
    """
    Test that the `_get_preliminary_info_fieldset` method returns the correct fieldset.

    Fieldset title should be empty and email, location and conditionally LinkedIn profile of the applicant should be
    returned as fields in the fieldset.
    """
    user_application.linkedin_url = linkedin_url

    expected_fieldset = ('', {'fields': expected_fields})
    actual_fieldset = UserApplicationADGAdmin._get_preliminary_info_fieldset('self', user_application)

    assert expected_fieldset == actual_fieldset


@pytest.mark.parametrize(
    'organization', [None, 'Test_organization']
)
@pytest.mark.django_db
def test_get_applicant_info_fieldset(user_application, organization):
    """
    Test that the `_get_applicant_info_fieldset` method returns the correct fieldset for both cases, i.e. when
    organization is:
        1. provided in the application
        2. not provided in the application
    """
    expected_fields = [IS_SAUDI_NATIONAL, GENDER, PHONE_NUMBER, DATE_OF_BIRTH]

    user_application.organization = organization
    if organization:
        expected_fields.append(ORGANIZATION)

    expected_fields.append(APPLYING_TO)

    expected_fieldset = (APPLICANT_INFO_FIELDSET_TITLE, {'fields': tuple(expected_fields)})
    actual_fieldset = UserApplicationADGAdmin._get_applicant_info_fieldset('self', user_application)

    assert expected_fieldset == actual_fieldset


@pytest.mark.parametrize('resume, cover_letter_file, cover_letter_text, expected_fieldset_title, expected_fields', [
    (TEST_RESUME, TEST_COVER_LETTER_FILE, None, RESUME_AND_COVER_LETTER, [RESUME, COVER_LETTER_FILE]),
    (TEST_RESUME, False, TEST_COVER_LETTER_TEXT, RESUME_AND_COVER_LETTER, [RESUME]),
    (TEST_RESUME, False, False, RESUME_ONLY, [RESUME]),
    (False, TEST_COVER_LETTER_FILE, False, COVER_LETTER_ONLY, [COVER_LETTER_FILE]),
    (False, False, TEST_COVER_LETTER_TEXT, COVER_LETTER_ONLY, [])
], ids=[
    'with_resume_and_cover_letter_file',
    'with_resume_and_cover_letter_text',
    'with_resume_only',
    'with_cover_letter_file_only',
    'with_cover_letter_text_only'
])
@pytest.mark.django_db
@mock.patch('openedx.adg.lms.applications.admin.UserApplicationADGAdmin._get_resume_cover_letter_display_fields')
def test_get_fieldset_for_resume_cover_letter(
    mock__get_resume_cover_letter_display_fields,
    user_application,
    user_application_adg_admin_instance,
    resume,
    cover_letter_file,
    cover_letter_text,
    expected_fieldset_title,
    expected_fields
):
    """
    Test that the `_get_fieldset_for_resume_cover_letter` method returns the correct fieldset.

    Correct fieldsets should be returned for all types of user applications, i.e. applications with both resume and
    cover letter, only resume, and only cover letter (in any format - file or text).
    """
    user_application.resume = resume
    user_application.cover_letter_file = cover_letter_file
    user_application.cover_letter = cover_letter_text

    test_display_field = ['display_field']
    mock__get_resume_cover_letter_display_fields.return_value = test_display_field
    expected_fields.extend(test_display_field)

    expected_fieldset = (expected_fieldset_title, {'fields': tuple(expected_fields)})
    actual_fieldset = UserApplicationADGAdmin._get_fieldset_for_resume_cover_letter(
        user_application_adg_admin_instance, user_application
    )

    assert expected_fieldset == actual_fieldset


@pytest.mark.parametrize(
    'resume, cover_letter_file, cover_letter_text, is_displayable_on_browser, expected_fields', [
        (TEST_RESUME, TEST_COVER_LETTER_FILE, None, True, [RESUME_DISPLAY, COVER_LETTER_FILE_DISPLAY]),
        (TEST_RESUME, TEST_COVER_LETTER_FILE, None, False, []),
        (None, None, TEST_COVER_LETTER_TEXT, None, [COVER_LETTER_TEXT])
    ], ids=[
        'with_displayable_resume_and_cover_letter_file',
        'with_undisplayable_resume_and_cover_letter_file',
        'with_cover_letter_text'
    ]
)
@pytest.mark.django_db
@mock.patch('openedx.adg.lms.applications.admin.is_displayable_on_browser')
def test_get_resume_cover_letter_display_fields(
    mock_is_displayable_on_browser,
    user_application,
    resume,
    cover_letter_file,
    cover_letter_text,
    is_displayable_on_browser,
    expected_fields
):
    """
    Test that the `_get_resume_cover_letter_display_fields` method correctly returns the list of display fields
    depending upon the data provided in the application.
    """
    user_application.resume = resume
    user_application.cover_letter_file = cover_letter_file
    user_application.cover_letter = cover_letter_text
    mock_is_displayable_on_browser.return_value = is_displayable_on_browser

    actual_fields = UserApplicationADGAdmin._get_resume_cover_letter_display_fields('self', user_application)

    assert expected_fields == actual_fields


def test_get_fieldset_for_scores():
    """
    Test that the `_get_fieldset_for_scores` method returns the correct fieldset.
    """
    expected_fieldset = (SCORES, {'fields': (PREREQUISITES,)})
    actual_fieldset = UserApplicationADGAdmin._get_fieldset_for_scores('self')

    assert expected_fieldset == actual_fieldset


@pytest.mark.parametrize(
    'resume, has_work_experience', [
        (None, False),
        (None, True),
        (TEST_RESUME, True)
    ], ids=['no_resume, no_experience', 'no_resume, with_experience', 'with_resume']
)
@pytest.mark.django_db
@mock.patch('openedx.adg.lms.applications.admin.ApplicationReviewInline.get_formset')
@mock.patch('openedx.adg.lms.applications.admin.UserApplicationADGAdmin.get_inline_instances')
def test_get_formsets_with_inlines(
    mock_get_inline_instances,
    mock_get_formset,
    user_application,
    user_application_adg_admin_instance,
    resume,
    has_work_experience
):
    """
    Test that the overridden generator function `get_formsets_with_inlines`:
        1. Yields no formsets in case of a user application with attached resume
        2. Yields formsets for both education and work experience in case the applicant has provided work experience
        3. Yields formset for only education in case of no work experience.
    """
    education_inline_instance = EducationInline(UserApplication, adg_admin_site)
    work_experience_inline_instance = WorkExperienceInline(UserApplication, adg_admin_site)

    mock_get_inline_instances.return_value = [education_inline_instance, work_experience_inline_instance]
    mock_get_formset.return_value = 'test_formset'

    user_application.resume = resume

    if has_work_experience:
        work_experience = WorkExperienceFactory()
        work_experience.user_application = user_application
        work_experience.save()

    actual_formsets = UserApplicationADGAdmin.get_formsets_with_inlines(
        user_application_adg_admin_instance, 'request', user_application
    )

    if resume:
        with pytest.raises(StopIteration):
            next(actual_formsets)
    else:
        assert next(actual_formsets) == ('test_formset', education_inline_instance)
        if has_work_experience:
            assert next(actual_formsets) == ('test_formset', work_experience_inline_instance)
        else:
            with pytest.raises(StopIteration):
                next(actual_formsets)


@pytest.mark.django_db
def test_get_form(user_application_adg_admin_instance, user_application, request):
    """
    Test that the `get_form` method returns a form with a request object attached.
    """
    admin_form_class = UserApplicationADGAdmin.get_form(user_application_adg_admin_instance, request, user_application)
    admin_form = admin_form_class()

    assert admin_form.request == request


def test_has_delete_permission():
    """
    Test that ADG admin is not allowed to delete an existing user application.
    """
    assert UserApplicationADGAdmin.has_delete_permission('self', 'request') is False


def test_has_add_permission():
    """
    Test that ADG admin is not allowed to add/create a new user application.
    """
    assert UserApplicationADGAdmin.has_add_permission('self', 'request') is False
