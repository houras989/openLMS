"""
Instructor tasks related to enrollments.
"""


import logging
from datetime import datetime
from time import time

from django.conf import settings
from django.contrib.sites.models import Site
from django.utils.translation import ugettext as _
from pytz import UTC
from six import StringIO

from common.djangoapps.edxmako.shortcuts import render_to_string
from lms.djangoapps.courseware.courses import get_course_by_id
from lms.djangoapps.instructor.enrollment import (
    enroll_email,
    get_email_params,
    get_user_email_language,
)
from lms.djangoapps.instructor_analytics.basic import enrolled_students_features, list_may_enroll
from lms.djangoapps.instructor_analytics.csvs import format_dictlist
from lms.djangoapps.instructor_task.models import ReportStore
from lms.djangoapps.instructor.views.tools import get_student_from_identifier
from openedx.core.lib.celery.task_utils import emulate_http_request
from shoppingcart.models import (
    CouponRedemption,
    CourseRegCodeItem,
    CourseRegistrationCode,
    Invoice,
    InvoiceTransaction,
    PaidCourseRegistration,
    RegistrationCodeRedemption
)
from common.djangoapps.student.models import CourseAccessRole, CourseEnrollment, User
from common.djangoapps.util.file import course_filename_prefix_generator

from .runner import TaskProgress
from .utils import tracker_emit, upload_csv_to_report_store

TASK_LOG = logging.getLogger('edx.celery.task')
FILTERED_OUT_ROLES = ['staff', 'instructor', 'finance_admin', 'sales_admin']


def upload_may_enroll_csv(_xmodule_instance_args, _entry_id, course_id, task_input, action_name):
    """
    For a given `course_id`, generate a CSV file containing
    information about students who may enroll but have not done so
    yet, and store using a `ReportStore`.
    """
    start_time = time()
    start_date = datetime.now(UTC)
    num_reports = 1
    task_progress = TaskProgress(action_name, num_reports, start_time)
    current_step = {'step': 'Calculating info about students who may enroll'}
    task_progress.update_task_state(extra_meta=current_step)

    # Compute result table and format it
    query_features = task_input.get('features')
    student_data = list_may_enroll(course_id, query_features)
    header, rows = format_dictlist(student_data, query_features)

    task_progress.attempted = task_progress.succeeded = len(rows)
    task_progress.skipped = task_progress.total - task_progress.attempted

    rows.insert(0, header)

    current_step = {'step': 'Uploading CSV'}
    task_progress.update_task_state(extra_meta=current_step)

    # Perform the upload
    upload_csv_to_report_store(rows, 'may_enroll_info', course_id, start_date)

    return task_progress.update_task_state(extra_meta=current_step)


def upload_students_csv(_xmodule_instance_args, _entry_id, course_id, task_input, action_name):
    """
    For a given `course_id`, generate a CSV file containing profile
    information for all students that are enrolled, and store using a
    `ReportStore`.
    """
    start_time = time()
    start_date = datetime.now(UTC)
    enrolled_students = CourseEnrollment.objects.users_enrolled_in(course_id)
    task_progress = TaskProgress(action_name, enrolled_students.count(), start_time)

    current_step = {'step': 'Calculating Profile Info'}
    task_progress.update_task_state(extra_meta=current_step)

    # compute the student features table and format it
    query_features = task_input
    student_data = enrolled_students_features(course_id, query_features)
    header, rows = format_dictlist(student_data, query_features)

    task_progress.attempted = task_progress.succeeded = len(rows)
    task_progress.skipped = task_progress.total - task_progress.attempted

    rows.insert(0, header)

    current_step = {'step': 'Uploading CSV'}
    task_progress.update_task_state(extra_meta=current_step)

    # Perform the upload
    upload_csv_to_report_store(rows, 'student_profile_info', course_id, start_date)

    return task_progress.update_task_state(extra_meta=current_step)


def get_executive_report(course_id):
    """
    Returns dict containing information about the course executive summary.
    """
    single_purchase_total = PaidCourseRegistration.get_total_amount_of_purchased_item(course_id)
    bulk_purchase_total = CourseRegCodeItem.get_total_amount_of_purchased_item(course_id)
    paid_invoices_total = InvoiceTransaction.get_total_amount_of_paid_course_invoices(course_id)
    gross_paid_revenue = single_purchase_total + bulk_purchase_total + paid_invoices_total

    all_invoices_total = Invoice.get_invoice_total_amount_for_course(course_id)
    gross_pending_revenue = all_invoices_total - float(paid_invoices_total)

    gross_revenue = float(gross_paid_revenue) + float(gross_pending_revenue)

    refunded_self_purchased_seats = PaidCourseRegistration.get_self_purchased_seat_count(
        course_id, status='refunded'
    )
    refunded_bulk_purchased_seats = CourseRegCodeItem.get_bulk_purchased_seat_count(
        course_id, status='refunded'
    )
    total_seats_refunded = refunded_self_purchased_seats + refunded_bulk_purchased_seats

    self_purchased_refunds = PaidCourseRegistration.get_total_amount_of_purchased_item(
        course_id,
        status='refunded'
    )
    bulk_purchase_refunds = CourseRegCodeItem.get_total_amount_of_purchased_item(course_id, status='refunded')
    total_amount_refunded = self_purchased_refunds + bulk_purchase_refunds

    top_discounted_codes = CouponRedemption.get_top_discount_codes_used(course_id)
    total_coupon_codes_purchases = CouponRedemption.get_total_coupon_code_purchases(course_id)

    bulk_purchased_codes = CourseRegistrationCode.order_generated_registration_codes(course_id)

    unused_registration_codes = 0
    for registration_code in bulk_purchased_codes:
        if not RegistrationCodeRedemption.is_registration_code_redeemed(registration_code.code):
            unused_registration_codes += 1

    self_purchased_seat_count = PaidCourseRegistration.get_self_purchased_seat_count(course_id)
    bulk_purchased_seat_count = CourseRegCodeItem.get_bulk_purchased_seat_count(course_id)
    total_invoiced_seats = CourseRegistrationCode.invoice_generated_registration_codes(course_id).count()

    total_seats = self_purchased_seat_count + bulk_purchased_seat_count + total_invoiced_seats

    self_purchases_percentage = 0.0
    bulk_purchases_percentage = 0.0
    invoice_purchases_percentage = 0.0
    avg_price_paid = 0.0

    if total_seats != 0:
        self_purchases_percentage = (float(self_purchased_seat_count) / float(total_seats)) * 100
        bulk_purchases_percentage = (float(bulk_purchased_seat_count) / float(total_seats)) * 100
        invoice_purchases_percentage = (float(total_invoiced_seats) / float(total_seats)) * 100
        avg_price_paid = gross_revenue / total_seats

    course = get_course_by_id(course_id, depth=0)
    currency = settings.PAID_COURSE_REGISTRATION_CURRENCY[1]

    return {
        'display_name': course.display_name,
        'start_date': course.start.strftime("%Y-%m-%d") if course.start is not None else 'N/A',
        'end_date': course.end.strftime("%Y-%m-%d") if course.end is not None else 'N/A',
        'total_seats': total_seats,
        'currency': currency,
        'gross_revenue': float(gross_revenue),
        'gross_paid_revenue': float(gross_paid_revenue),
        'gross_pending_revenue': gross_pending_revenue,
        'total_seats_refunded': total_seats_refunded,
        'total_amount_refunded': float(total_amount_refunded),
        'average_paid_price': float(avg_price_paid),
        'discount_codes_data': top_discounted_codes,
        'total_seats_using_discount_codes': total_coupon_codes_purchases,
        'total_self_purchase_seats': self_purchased_seat_count,
        'total_bulk_purchase_seats': bulk_purchased_seat_count,
        'total_invoiced_seats': total_invoiced_seats,
        'unused_bulk_purchase_code_count': unused_registration_codes,
        'self_purchases_percentage': self_purchases_percentage,
        'bulk_purchases_percentage': bulk_purchases_percentage,
        'invoice_purchases_percentage': invoice_purchases_percentage,
    }


def upload_exec_summary_report(_xmodule_instance_args, _entry_id, course_id, _task_input, action_name):
    """
    For a given `course_id`, generate a html report containing information,
    which provides a snapshot of how the course is doing.
    """
    start_time = time()
    report_generation_date = datetime.now(UTC)
    status_interval = 100

    enrolled_users = CourseEnrollment.objects.users_enrolled_in(course_id)
    true_enrollment_count = 0
    for user in enrolled_users:
        if not user.is_staff and not CourseAccessRole.objects.filter(
                user=user, course_id=course_id, role__in=FILTERED_OUT_ROLES
        ).exists():
            true_enrollment_count += 1

    task_progress = TaskProgress(action_name, true_enrollment_count, start_time)

    fmt = u'Task: {task_id}, InstructorTask ID: {entry_id}, Course: {course_id}, Input: {task_input}'
    task_info_string = fmt.format(
        task_id=_xmodule_instance_args.get('task_id') if _xmodule_instance_args is not None else None,
        entry_id=_entry_id,
        course_id=course_id,
        task_input=_task_input
    )

    TASK_LOG.info(u'%s, Task type: %s, Starting task execution', task_info_string, action_name)
    current_step = {'step': 'Gathering executive summary report information'}

    TASK_LOG.info(
        u'%s, Task type: %s, Current step: %s, generating executive summary report',
        task_info_string,
        action_name,
        current_step
    )

    if task_progress.attempted % status_interval == 0:
        task_progress.update_task_state(extra_meta=current_step)
    task_progress.attempted += 1

    # get the course executive summary report information.
    data_dict = get_executive_report(course_id)
    data_dict.update(
        {
            'total_enrollments': true_enrollment_count,
            'report_generation_date': report_generation_date.strftime("%Y-%m-%d"),
        }
    )

    # By this point, we've got the data that we need to generate html report.
    current_step = {'step': 'Uploading executive summary report HTML file'}
    task_progress.update_task_state(extra_meta=current_step)
    TASK_LOG.info(u'%s, Task type: %s, Current step: %s', task_info_string, action_name, current_step)

    # Perform the actual upload
    _upload_exec_summary_to_store(data_dict, 'executive_report', course_id, report_generation_date)
    task_progress.succeeded += 1
    # One last update before we close out...
    TASK_LOG.info(u'%s, Task type: %s, Finalizing executive summary report task', task_info_string, action_name)
    return task_progress.update_task_state(extra_meta=current_step)


def _upload_exec_summary_to_store(data_dict, report_name, course_id, generated_at, config_name='FINANCIAL_REPORTS'):
    """
    Upload Executive Summary Html file using ReportStore.

    Arguments:
        data_dict: containing executive report data.
        report_name: Name of the resulting Html File.
        course_id: ID of the course
    """
    report_store = ReportStore.from_config(config_name)

    # Use the data dict and html template to generate the output buffer
    output_buffer = StringIO(render_to_string("instructor/instructor_dashboard_2/executive_summary.html", data_dict))

    report_store.store(
        course_id,
        u"{course_prefix}_{report_name}_{timestamp_str}.html".format(
            course_prefix=course_filename_prefix_generator(course_id),
            report_name=report_name,
            timestamp_str=generated_at.strftime("%Y-%m-%d-%H%M")
        ),
        output_buffer,
    )
    tracker_emit(report_name)


def enroll_user_to_course(request_info, course_id, username_or_email, site_name=None, context_vars=None):
    """
    Look up the given user, and if successful, enroll them to the specified course.

    Arguments:
        request_info (dict): Dict containing task request information
        course_id (str): The ID string of the course
        username_or_email: user's username or email string

    Returns:
        User object (or None if user in not registered,
        and whether the user is already enrolled or not

    """
    # First try to get a user object from the identifier (email)
    user = None
    user_already_enrolled = False
    language = None
    email_students = True
    auto_enroll = True
    thread_site = Site.objects.get(domain=request_info['host'])
    thread_author = User.objects.get(username=request_info['username'])

    try:
        user = get_student_from_identifier(username_or_email)
    except User.DoesNotExist:
        email = username_or_email
    else:
        email = user.email
        language = get_user_email_language(user)

    if user:
        course_enrollment = CourseEnrollment.get_enrollment(user=user, course_key=course_id)
        if course_enrollment:
            user_already_enrolled = True
            # Set the enrollment to active if its not already active
            if not course_enrollment.is_active:
                course_enrollment.update_enrollment(is_active=True)

    if not user or not user_already_enrolled:
        course = get_course_by_id(course_id, depth=0)
        try:
            with emulate_http_request(site=thread_site, user=thread_author):
                email_params = get_email_params(course=course, auto_enroll=auto_enroll, site_name=site_name)
                __ = enroll_email(
                    course_id, email, auto_enroll, email_students,
                    email_params, language=language, context_vars=context_vars, site=thread_site
                )
                if user:
                    TASK_LOG.info(
                        u'User %s enrolled successfully in course %s via CSV bulk enrollment',
                        username_or_email,
                        course_id
                    )
        except:
            TASK_LOG.exception(
                u'There was an error enrolling user %s in course %s via CSV bulk enrollment',
                username_or_email,
                course_id
            )
            return None, None

    return user, user_already_enrolled
