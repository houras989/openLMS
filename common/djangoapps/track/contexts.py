"""Generates common contexts"""
import logging

from opaque_keys.edx.locations import SlashSeparatedCourseKey
from opaque_keys import InvalidKeyError
from util.request import course_id_from_url

log = logging.getLogger(__name__)


def course_context_from_url(url):
    """
    Extracts the course_context from the given `url` and passes it on to
    `course_context_from_course_id()`.
    """
    url = url or ''
    course_id = course_id_from_url(url)
    return course_context_from_course_id(course_id)


def course_context_from_course_id(course_id):
    """
    Creates a course context from a `course_id`.

    Example Returned Context::

        {
            'course_id': 'org/course/run',
            'org_id': 'org'
        }

    """
    if course_id is None:
        return {'course_id': '', 'org_id': ''}

    # TODO: Make this accept any CourseKey, and serialize it using .to_string
    assert(isinstance(course_id, SlashSeparatedCourseKey))
    return {
        'course_id': course_id.to_deprecated_string(),
        'org_id': course_id.org,
    }
