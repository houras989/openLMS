"""
This file contains all entrance exam related utils/logic.
"""


from opaque_keys.edx.keys import UsageKey

from lms.djangoapps.courseware.access import has_access
from common.djangoapps.student.models.student import EntranceExamConfiguration
from common.djangoapps.util.milestones_helpers import get_required_content
from openedx.core.toggles import ENTRANCE_EXAMS
from xmodule.modulestore.django import modulestore  # lint-amnesty, pylint: disable=wrong-import-order


def course_has_entrance_exam(course):
    """
    Checks to see if a course is properly configured for an entrance exam
    """
    if not ENTRANCE_EXAMS.is_enabled():
        return False
    entrance_exam_enabled = getattr(course, 'entrance_exam_enabled', None)
    if not entrance_exam_enabled:
        return False
    if not course.entrance_exam_id:
        return False
    return True


def user_can_skip_entrance_exam(user, course):
    """
    Checks all of the various override conditions for a user to skip an entrance exam
    Begin by short-circuiting if the course does not have an entrance exam
    """
    if not course_has_entrance_exam(course):
        return True
    if not user.is_authenticated:
        return False
    if has_access(user, 'staff', course):
        return True
    if EntranceExamConfiguration.user_can_skip_entrance_exam(user, course.id):
        return True
    if not get_entrance_exam_content(user, course):
        return True
    return False


def user_has_passed_entrance_exam(user, course):
    """
    Checks to see if the user has attained a sufficient score to pass the exam
    Begin by short-circuiting if the course does not have an entrance exam
    """
    if not course_has_entrance_exam(course):
        return True
    if not user.is_authenticated:
        return False
    return get_entrance_exam_content(user, course) is None


def get_entrance_exam_content(user, course):
    """
    Get the entrance exam content information (ie, chapter module)
    """
    required_content = get_required_content(course.id, user)

    exam_module = None
    for content in required_content:
        usage_key = UsageKey.from_string(content).map_into_course(course.id)
        module_item = modulestore().get_item(usage_key)
        if not module_item.hide_from_toc and module_item.is_entrance_exam:
            exam_module = module_item
            break
    return exam_module
