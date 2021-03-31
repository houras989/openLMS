"""
Progress Email related signal handlers.
"""

from logging import getLogger
from django.dispatch import receiver

from student.models import EnrollStatusChange
from student.signals import ENROLL_STATUS_CHANGE
from openedx.features.pakx.lms.overrides.tasks import add_enrollment_record, remove_enrollment_record


log = getLogger(__name__)


@receiver(ENROLL_STATUS_CHANGE)
def copy_active_course_enrollment(sender, event=None, user=None, **kwargs):  # pylint: disable=unused-argument
    """
    Awards enrollment badge to the given user on new enrollments.
    """

    if event == EnrollStatusChange.enroll:
        add_enrollment_record.delay(user.username, user.email, kwargs.get('course_id'))
    elif event == EnrollStatusChange.unenroll:
        remove_enrollment_record.delay(user.username, user.email, kwargs.get('course_id'))
