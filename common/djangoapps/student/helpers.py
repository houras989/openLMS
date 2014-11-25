"""Helpers for the student app. """
import time
from datetime import datetime
from pytz import UTC
from django.utils.http import cookie_date
from django.conf import settings
from django.core.urlresolvers import reverse
from opaque_keys.edx.keys import CourseKey
from course_modes.models import CourseMode
from third_party_auth import (  # pylint: disable=W0611
    pipeline, provider,
    is_enabled as third_party_auth_enabled
)
from verify_student.models import SoftwareSecurePhotoVerification


def auth_pipeline_urls(auth_entry, redirect_url=None, course_id=None):
    """Retrieve URLs for each enabled third-party auth provider.

    These URLs are used on the "sign up" and "sign in" buttons
    on the login/registration forms to allow users to begin
    authentication with a third-party provider.

    Optionally, we can redirect the user to an arbitrary
    url after auth completes successfully.  We use this
    to redirect the user to a page that required login,
    or to send users to the payment flow when enrolling
    in a course.

    Args:
        auth_entry (string): Either `pipeline.AUTH_ENTRY_LOGIN` or `pipeline.AUTH_ENTRY_REGISTER`

    Keyword Args:
        redirect_url (unicode): If provided, send users to this URL
            after they successfully authenticate.

        course_id (unicode): The ID of the course the user is enrolling in.
            We use this to send users to the track selection page
            if the course has a payment option.
            Note that `redirect_url` takes precedence over the redirect
            to the track selection page.

    Returns:
        dict mapping provider names to URLs

    """
    if not third_party_auth_enabled():
        return {}

    if redirect_url is not None:
        pipeline_redirect = redirect_url
    elif course_id is not None:
        # If the course is white-label (paid), then we send users
        # to the shopping cart.  (There is a third party auth pipeline
        # step that will add the course to the cart.)
        if CourseMode.is_white_label(CourseKey.from_string(course_id)):
            pipeline_redirect = reverse("shoppingcart.views.show_cart")

        # Otherwise, send the user to the track selection page.
        # The track selection page may redirect the user to the dashboard
        # (if the only available mode is honor), or directly to verification
        # (for professional ed).
        else:
            pipeline_redirect = reverse(
                "course_modes_choose",
                kwargs={'course_id': unicode(course_id)}
            )
    else:
        pipeline_redirect = None

    return {
        provider.NAME: pipeline.get_login_url(
            provider.NAME, auth_entry,
            enroll_course_id=course_id,
            redirect_url=pipeline_redirect
        )
        for provider in provider.Registry.enabled()
    }


def set_logged_in_cookie(request, response):
    """Set a cookie indicating that the user is logged in.

    Some installations have an external marketing site configured
    that displays a different UI when the user is logged in
    (e.g. a link to the student dashboard instead of to the login page)

    Arguments:
        request (HttpRequest): The request to the view, used to calculate
            the cookie's expiration date based on the session expiration date.
        response (HttpResponse): The response on which the cookie will be set.

    Returns:
        HttpResponse

    """
    if request.session.get_expire_at_browser_close():
        max_age = None
        expires = None
    else:
        max_age = request.session.get_expiry_age()
        expires_time = time.time() + max_age
        expires = cookie_date(expires_time)

    response.set_cookie(
        settings.EDXMKTG_COOKIE_NAME, 'true', max_age=max_age,
        expires=expires, domain=settings.SESSION_COOKIE_DOMAIN,
        path='/', secure=None, httponly=None,
    )

    return response


def is_logged_in_cookie_set(request):
    """Check whether the request has the logged in cookie set. """
    return settings.EDXMKTG_COOKIE_NAME in request.COOKIES


# Enumeration of per-course verification statuses
# we display on the student dashboard.
VERIFY_STATUS_NEED_TO_VERIFY = "verify_need_to_verify"
VERIFY_STATUS_SUBMITTED = "verify_submitted"
VERIFY_STATUS_APPROVED = "verify_approved"
VERIFY_STATUS_MISSED_DEADLINE = "verify_missed_deadline"


def check_verify_status_by_course(user, course_enrollment_pairs, all_course_modes):
    """Determine the per-course verification statuses for a given user.

    The possible statuses are:
        * VERIFY_STATUS_NEED_TO_VERIFY: The student has not yet submitted photos for verification.
        * VERIFY_STATUS_SUBMITTED: The student has submitted photos for verification,
          but has have not yet been approved.
        * VERIFY_STATUS_APPROVED: The student has been successfully verified.
        * VERIFY_STATUS_MISSED_DEADLINE: The student did not submit photos within the course's deadline.

    It is is also possible that a course does NOT have a verification status if:
        * The user is not enrolled in a verified mode, meaning that the user didn't pay.
        * The course does not offer a verified mode.
        * The user submitted photos but an error occurred while verifying them.
        * The user submitted photos but the verification was denied.

    In the last two cases, we rely on messages in the sidebar rather than displaying
    messages for each course.

    Arguments:
        user (User): The currently logged-in user.
        course_enrollment_pairs (list): The courses the user is enrolled in.
            The list should contain tuples of `(Course, CourseEnrollment)`.
        all_course_modes (list): List of all course modes for the student's enrolled courses,
            including modes that have expired.

    Returns:
        dict: Mapping of course keys to an enumerated verification status.
            If no verification status is applicable to a course, it will not
            be included in the dictionary.
    """

    status_by_course = {}

    # Retrieve all verifications for the user, sorted in descending
    # order by submission datetime
    verifications = SoftwareSecurePhotoVerification.objects.filter(user=user)

    for course, enrollment in course_enrollment_pairs:

        # Get the verified mode (if any) for this course
        # We pass in the course modes we have already loaded to avoid
        # another database hit, as well as to ensure that expired
        # course modes are included in the search.
        verified_mode = CourseMode.verified_mode_for_course(
            course.id,
            modes=all_course_modes[course.id]
        )

        # If no verified mode has ever been offered, or the user hasn't enrolled
        # as verified, then the course won't display state related to its
        # verification status.
        if verified_mode is not None and enrollment.mode in CourseMode.VERIFIED_MODES:
            deadline = verified_mode.expiration_datetime
            relevant_verification = SoftwareSecurePhotoVerification.verification_for_datetime(deadline, verifications)

            # By default, don't show any status related to verification
            status = None

            # Check whether the user was approved or is awaiting approval
            if relevant_verification is not None:
                if relevant_verification.status == "approved":
                    status = VERIFY_STATUS_APPROVED
                elif relevant_verification.status == "submitted":
                    status = VERIFY_STATUS_SUBMITTED

            # If the user didn't submit at all, then tell them they need to verify
            # If the deadline has already passed, then tell them they missed it.
            # If they submitted but something went wrong (error or denied),
            # then don't show any messaging next to the course, since we already
            # show messages related to this on the left sidebar.
            submitted = (
                relevant_verification is not None and
                relevant_verification.status not in ["created", "ready"]
            )
            if status is None and not submitted:
                if deadline is None or deadline > datetime.now(UTC):
                    status = VERIFY_STATUS_NEED_TO_VERIFY
                else:
                    status = VERIFY_STATUS_MISSED_DEADLINE

            # Set the status for the course only if we're displaying some kind of message
            # Otherwise, leave the course out of the dictionary.
            if status is not None:
                status_by_course[course.id] = status

    return status_by_course
