import waffle
from django.conf import settings

from courseware.access_utils import ACCESS_DENIED, ACCESS_GRANTED
from lms.djangoapps.courseware.access import _has_staff_access_to_descriptor
from openedx.features.subscriptions.models import UserSubscription

from student.models import User
from enrollment import api
from enrollment.data import get_course_enrollment
from student.models import CourseEnrollment


def track_subscription_enrollment(subscription_id, user, course_id, site):
    """
    Add user enrollment to valid subscription.
    """
    if subscription_id:
        try:
            enrollment = CourseEnrollment.objects.get(
                user=user, course_id=course_id
            )
        except CourseEnrollment.DoesNotExist:
            enrollment = None
        valid_user_subscription = UserSubscription.get_valid_subscriptions(site, username=user.username).first()
        if valid_user_subscription and valid_user_subscription.subscription_id == subscription_id:
            valid_user_subscription.course_enrollments.add(enrollment)
            valid_user_subscription.save()


def is_course_accessible_with_subscription(user, course):
    """
    Check if user has access to a course enrolled through subscription.
    """
    if waffle.switch_is_active(settings.ENABLE_SUBSCRIPTIONS_ON_RUNTIME_SWITCH):
        return ACCESS_GRANTED

    if not user or not user.is_authenticated:
        return ACCESS_DENIED

    course_enrolled_subscriptions = UserSubscription.objects.filter(user=user, course_enrollments__course__id=course.id)
    if not course_enrolled_subscriptions:
        return ACCESS_GRANTED

    for subscription in course_enrolled_subscriptions:
        if subscription.is_active:
            return ACCESS_GRANTED

    return _has_staff_access_to_descriptor(user, course, course.id)
