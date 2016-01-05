"""Helper functions for working with Programs."""
import logging
from urlparse import urljoin

from openedx.core.djangoapps.credentials.models import CredentialsApiConfig
from openedx.core.djangoapps.programs.models import ProgramsApiConfig
from openedx.core.lib.api_utils import get_api_data


log = logging.getLogger(__name__)


def get_programs(user):
    """Given a user, get programs from the Programs service.
    Returned value is cached depending on user permissions. Staff users making requests
    against Programs will receive unpublished programs, while regular users will only receive
    published programs.

    Arguments:
        user (User): The user to authenticate as when requesting programs.

    Returns:
        list of dict, representing programs returned by the Programs service.
    """
    programs_config = ProgramsApiConfig.current()

    # Bypass caching for staff users, who may be creating Programs and want to see them displayed immediately.
    use_cache = programs_config.is_cache_enabled and not user.is_staff
    return get_api_data(programs_config, user, programs_config.API_NAME, 'programs', use_cache=use_cache)



def get_programs_for_dashboard(user, course_keys):
    """Build a dictionary of programs, keyed by course.

    Given a user and an iterable of course keys, find all the programs relevant
    to the user's dashboard and return them in a dictionary keyed by course key.

    Arguments:
        user (User): The user to authenticate as when requesting programs.
        course_keys (list): List of course keys representing the courses in which
            the given user has active enrollments.

    Returns:
        dict, containing programs keyed by course. Empty if programs cannot be retrieved.
    """
    programs_config = ProgramsApiConfig.current()
    course_programs = {}

    if not programs_config.is_student_dashboard_enabled:
        log.debug('Display of programs on the student dashboard is disabled.')
        return course_programs

    programs = get_programs(user)
    if not programs:
        log.debug('No programs found for the user with ID %d.', user.id)
        return course_programs

    # Convert course keys to Unicode representation for efficient lookup.
    course_keys = map(unicode, course_keys)

    # Reindex the result returned by the Programs API from:
    #     program -> course code -> course run
    # to:
    #     course run -> program
    # Ignore course runs not present in the user's active enrollments.
    for program in programs:
        try:
            for course_code in program['course_codes']:
                for run in course_code['run_modes']:
                    course_key = run['course_key']
                    if course_key in course_keys:
                        course_programs[course_key] = program
        except KeyError:
            log.exception('Unable to parse Programs API response: %r', program)

    return course_programs


def get_programs_for_credentials(user, programs_credentials):
    """ Given a user and an iterable of credentials, get corresponding programs
    data and return it as a list of dictionaries.

    Arguments:
        user (User): The user to authenticate as for requesting programs.
        programs_credentials (list): List of credentials awarded to the user
            for completion of a program.

    Returns:
        list, containing programs dictionaries.
    """
    programs_config = ProgramsApiConfig.current()
    certificate_programs = []

    programs = get_programs(user)
    if not programs:
        log.debug('No programs found for the user with ID %d.', user.id)
        return certificate_programs

    credential_configuration = CredentialsApiConfig.current()
    for program in programs:
        for credential in programs_credentials:
            if program['id'] == credential['credential']['program_id']:
                credentials_url = 'credentials/' + credential['uuid']
                program['credential_url'] = urljoin(credential_configuration.public_service_url, credentials_url)
                certificate_programs.append(program)

    return certificate_programs
