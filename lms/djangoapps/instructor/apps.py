"""
Instructor Application Configuration
"""

from django.apps import AppConfig
from django.conf import settings
from edx_proctoring.runtime import set_runtime_service
from openedx.core.constants import COURSE_ID_PATTERN
from openedx.core.djangoapps.plugins.constants import ProjectType, SettingsType, PluginURLs, PluginSettings


class InstructorConfig(AppConfig):
    """
    Application Configuration for Instructor.
    """
    name = 'lms.djangoapps.instructor'

    plugin_app = {
        PluginURLs.CONFIG: {
            ProjectType.LMS: {
                PluginURLs.NAMESPACE: '',
                PluginURLs.REGEX: 'courses/{}/instructor/api/'.format(COURSE_ID_PATTERN),
                PluginURLs.RELATIVE_PATH: 'views.api_urls',
            }
        },
        PluginSettings.CONFIG: {
            ProjectType.LMS: {
                SettingsType.DEVSTACK: {PluginSettings.RELATIVE_PATH: 'settings.devstack'},
                SettingsType.AWS: {PluginSettings.RELATIVE_PATH: 'settings.aws'},
                SettingsType.COMMON: {PluginSettings.RELATIVE_PATH: 'settings.common'},
                SettingsType.TEST: {PluginSettings.RELATIVE_PATH: 'settings.test'},
            }
        }
    }

    def ready(self):
        if settings.FEATURES.get('ENABLE_SPECIAL_EXAMS'):
            from .services import InstructorService
            set_runtime_service('instructor', InstructorService())
