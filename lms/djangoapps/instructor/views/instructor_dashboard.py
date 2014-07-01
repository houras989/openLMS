"""
Instructor Dashboard Views
"""

from django.utils.translation import ugettext as _
from django_future.csrf import ensure_csrf_cookie
from django.views.decorators.cache import cache_control
from edxmako.shortcuts import render_to_response
from django.contrib.auth.models import User
from django.core.urlresolvers import reverse
from django.utils.html import escape
from django.http import Http404
from django.conf import settings

from lms.lib.xblock.runtime import quote_slashes
from xmodule_modifiers import wrap_xblock
from xmodule.html_module import HtmlDescriptor
from xmodule.modulestore import ModuleStoreEnum
from xmodule.modulestore.django import modulestore
from xblock.field_data import DictFieldData
from xblock.fields import ScopeIds
from courseware.access import has_access
from courseware.courses import get_course_by_id, get_cms_course_link, get_course_with_access
from django_comment_client.utils import has_forum_access
from django_comment_common.models import FORUM_ROLE_ADMINISTRATOR
from student.models import CourseEnrollment
from bulk_email.models import CourseAuthorization
from class_dashboard.dashboard_data import get_section_display_name, get_array_section_has_problem

from analyticsclient.client import RestClient
from analyticsclient.course import Course

from .tools import get_units_with_due_date, title_or_url, bulk_email_is_enabled_for_course
from opaque_keys.edx.keys import CourseKey


@ensure_csrf_cookie
@cache_control(no_cache=True, no_store=True, must_revalidate=True)
def instructor_dashboard_2(request, course_id):
    """ Display the instructor dashboard for a course. """
    course_key = CourseKey.from_string(course_id)
    course = get_course_by_id(course_key, depth=None)
    is_studio_course = (modulestore().get_modulestore_type(course_key) != ModuleStoreEnum.Type.xml)

    access = {
        'admin': request.user.is_staff,
        'instructor': has_access(request.user, 'instructor', course),
        'staff': has_access(request.user, 'staff', course),
        'forum_admin': has_forum_access(
            request.user, course_key, FORUM_ROLE_ADMINISTRATOR
        ),
    }

    if not access['staff']:
        raise Http404()

    sections = [
        _section_course_info(course_key, access),
        _section_membership(course_key, access),
        _section_student_admin(course_key, access),
        _section_data_download(course_key, access),
        _section_analytics(course_key, access),
    ]

    if (settings.FEATURES.get('INDIVIDUAL_DUE_DATES') and access['instructor']):
        sections.insert(3, _section_extensions(course))

    # Gate access to course email by feature flag & by course-specific authorization
    if bulk_email_is_enabled_for_course(course_key):
        sections.append(_section_send_email(course_key, access, course))

    # Gate access to Metrics tab by featue flag and staff authorization
    if settings.FEATURES['CLASS_DASHBOARD'] and access['staff']:
        sections.append(_section_metrics(course_key, access))

    studio_url = None
    if is_studio_course:
        studio_url = get_cms_course_link(course)

    enrollment_count = sections[0]['enrollment_count']
    disable_buttons = False
    max_enrollment_for_buttons = settings.FEATURES.get("MAX_ENROLLMENT_INSTR_BUTTONS")
    if max_enrollment_for_buttons is not None:
        disable_buttons = enrollment_count > max_enrollment_for_buttons

    context = {
        'course': course,
        'old_dashboard_url': reverse('instructor_dashboard_legacy', kwargs={'course_id': unicode(course_key)}),
        'studio_url': studio_url,
        'sections': sections,
        'disable_buttons': disable_buttons,
    }

    return render_to_response('instructor/instructor_dashboard_2/instructor_dashboard_2.html', context)


"""
Section functions starting with _section return a dictionary of section data.

The dictionary must include at least {
    'section_key': 'circus_expo'
    'section_display_name': 'Circus Expo'
}

section_key will be used as a css attribute, javascript tie-in, and template import filename.
section_display_name will be used to generate link titles in the nav bar.
"""  # pylint: disable=W0105


def _section_course_info(course_key, access):
    """ Provide data for the corresponding dashboard section """
    course = get_course_by_id(course_key, depth=None)

    section_data = {
        'section_key': 'course_info',
        'section_display_name': _('Course Info'),
        'access': access,
        'course_id': course_key,
        'course_display_name': course.display_name,
        'enrollment_count': CourseEnrollment.num_enrolled_in(course_key),
        'has_started': course.has_started(),
        'has_ended': course.has_ended(),
        'list_instructor_tasks_url': reverse('list_instructor_tasks', kwargs={'course_id': unicode(course_key)}),
    }

    try:
        advance = lambda memo, (letter, score): "{}: {}, ".format(letter, score) + memo
        section_data['grade_cutoffs'] = reduce(advance, course.grade_cutoffs.items(), "")[:-2]
    except Exception:
        section_data['grade_cutoffs'] = "Not Available"
    # section_data['offline_grades'] = offline_grades_available(course_key)

    try:
        section_data['course_errors'] = [(escape(a), '') for (a, _unused) in modulestore().get_course_errors(course.id)]
    except Exception:
        section_data['course_errors'] = [('Error fetching errors', '')]

    return section_data


def _section_membership(course_key, access):
    """ Provide data for the corresponding dashboard section """
    section_data = {
        'section_key': 'membership',
        'section_display_name': _('Membership'),
        'access': access,
        'enroll_button_url': reverse('students_update_enrollment', kwargs={'course_id': unicode(course_key)}),
        'unenroll_button_url': reverse('students_update_enrollment', kwargs={'course_id': unicode(course_key)}),
        'modify_beta_testers_button_url': reverse('bulk_beta_modify_access', kwargs={'course_id': unicode(course_key)}),
        'list_course_role_members_url': reverse('list_course_role_members', kwargs={'course_id': unicode(course_key)}),
        'modify_access_url': reverse('modify_access', kwargs={'course_id': unicode(course_key)}),
        'list_forum_members_url': reverse('list_forum_members', kwargs={'course_id': unicode(course_key)}),
        'update_forum_role_membership_url': reverse('update_forum_role_membership', kwargs={'course_id': unicode(course_key)}),
    }
    return section_data


def _section_student_admin(course_key, access):
    """ Provide data for the corresponding dashboard section """
    is_small_course = False
    enrollment_count = CourseEnrollment.num_enrolled_in(course_key)
    max_enrollment_for_buttons = settings.FEATURES.get("MAX_ENROLLMENT_INSTR_BUTTONS")
    if max_enrollment_for_buttons is not None:
        is_small_course = enrollment_count <= max_enrollment_for_buttons

    section_data = {
        'section_key': 'student_admin',
        'section_display_name': _('Student Admin'),
        'access': access,
        'is_small_course': is_small_course,
        'get_student_progress_url_url': reverse('get_student_progress_url', kwargs={'course_id': unicode(course_key)}),
        'enrollment_url': reverse('students_update_enrollment', kwargs={'course_id': unicode(course_key)}),
        'reset_student_attempts_url': reverse('reset_student_attempts', kwargs={'course_id': unicode(course_key)}),
        'rescore_problem_url': reverse('rescore_problem', kwargs={'course_id': unicode(course_key)}),
        'list_instructor_tasks_url': reverse('list_instructor_tasks', kwargs={'course_id': unicode(course_key)}),
        'spoc_gradebook_url': reverse('spoc_gradebook', kwargs={'course_id': unicode(course_key)}),
    }
    return section_data


def _section_extensions(course):
    """ Provide data for the corresponding dashboard section """
    section_data = {
        'section_key': 'extensions',
        'section_display_name': _('Extensions'),
        'units_with_due_dates': [(title_or_url(unit), unicode(unit.location))
                                 for unit in get_units_with_due_date(course)],
        'change_due_date_url': reverse('change_due_date', kwargs={'course_id': unicode(course.id)}),
        'reset_due_date_url': reverse('reset_due_date', kwargs={'course_id': unicode(course.id)}),
        'show_unit_extensions_url': reverse('show_unit_extensions', kwargs={'course_id': unicode(course.id)}),
        'show_student_extensions_url': reverse('show_student_extensions', kwargs={'course_id': unicode(course.id)}),
    }
    return section_data


def _section_data_download(course_key, access):
    """ Provide data for the corresponding dashboard section """
    section_data = {
        'section_key': 'data_download',
        'section_display_name': _('Data Download'),
        'access': access,
        'get_grading_config_url': reverse('get_grading_config', kwargs={'course_id': unicode(course_key)}),
        'get_students_features_url': reverse('get_students_features', kwargs={'course_id': unicode(course_key)}),
        'get_anon_ids_url': reverse('get_anon_ids', kwargs={'course_id': unicode(course_key)}),
        'list_instructor_tasks_url': reverse('list_instructor_tasks', kwargs={'course_id': unicode(course_key)}),
        'list_report_downloads_url': reverse('list_report_downloads', kwargs={'course_id': unicode(course_key)}),
        'calculate_grades_csv_url': reverse('calculate_grades_csv', kwargs={'course_id': unicode(course_key)}),
    }
    return section_data


def _section_send_email(course_key, access, course):
    """ Provide data for the corresponding bulk email section """
    html_module = HtmlDescriptor(
        course.system,
        DictFieldData({'data': ''}),
        ScopeIds(None, None, None, course_key.make_usage_key('html', 'fake'))
    )
    fragment = course.system.render(html_module, 'studio_view')
    fragment = wrap_xblock(
        'LmsRuntime', html_module, 'studio_view', fragment, None,
        extra_data={"course-id": unicode(course_key)},
        usage_id_serializer=lambda usage_id: quote_slashes(unicode(usage_id))
    )
    email_editor = fragment.content
    section_data = {
        'section_key': 'send_email',
        'section_display_name': _('Email'),
        'access': access,
        'send_email': reverse('send_email', kwargs={'course_id': unicode(course_key)}),
        'editor': email_editor,
        'list_instructor_tasks_url': reverse(
            'list_instructor_tasks', kwargs={'course_id': unicode(course_key)}
        ),
        'email_background_tasks_url': reverse(
            'list_background_email_tasks', kwargs={'course_id': unicode(course_key)}
        ),
    }
    return section_data


def _section_analytics(course_key, access):
    """ Provide data for the corresponding dashboard section """
    section_data = {
        'section_key': 'analytics',
        'section_display_name': _('Analytics'),
        'access': access,
        'get_distribution_url': reverse('get_distribution', kwargs={'course_id': unicode(course_key)}),
        'proxy_legacy_analytics_url': reverse('proxy_legacy_analytics', kwargs={'course_id': unicode(course_key)}),
    }

    if settings.FEATURES.get('ENABLE_ANALYTICS_ACTIVE_COUNT'):
        auth_token = settings.ANALYTICS_DATA_TOKEN
        base_url = settings.ANALYTICS_DATA_URL

        client = RestClient(base_url=base_url, auth_token=auth_token)
        course = Course(client, course_key)

        section_data['active_student_count'] = course.recent_active_user_count['count']

        def format_date(value):
            return value.split('T')[0]

        start = course.recent_active_user_count['interval_start']
        end = course.recent_active_user_count['interval_end']

        section_data['active_student_count_start'] = format_date(start)
        section_data['active_student_count_end'] = format_date(end)

    return section_data


def _section_metrics(course_key, access):
    """Provide data for the corresponding dashboard section """
    section_data = {
        'section_key': 'metrics',
        'section_display_name': _('Metrics'),
        'access': access,
        'course_id': unicode(course_key),
        'sub_section_display_name': get_section_display_name(course_key),
        'section_has_problem': get_array_section_has_problem(course_key),
        'get_students_opened_subsection_url': reverse('get_students_opened_subsection'),
        'get_students_problem_grades_url': reverse('get_students_problem_grades'),
        'post_metrics_data_csv_url': reverse('post_metrics_data_csv'),
    }
    return section_data
