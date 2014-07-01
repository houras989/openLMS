"""Generates common contexts"""
import logging

from opaque_keys.edx.keys import CourseKey
from opaque_keys import InvalidKeyError
from util.request import COURSE_REGEX

log = logging.getLogger(__name__)


def course_context_from_url(url):
    """
    Extracts the course_context from the given `url` and passes it on to
    `course_context_from_course_id()`.
    """
    url = url or ''

    match = COURSE_REGEX.match(url)
    course_id = None
    if match:
        course_id_string = match.group('course_id')
        try:
            course_id = CourseKey.from_string(course_id_string)
        except InvalidKeyError:
            log.warning(
                'unable to parse course_id "{course_id}"'.format(
                    course_id=course_id_string
                ),
                exc_info=True
            )

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

    assert(isinstance(course_id, CourseKey))
    return {
        'course_id': unicode(course_id),
        'org_id': course_id.org,
    }
