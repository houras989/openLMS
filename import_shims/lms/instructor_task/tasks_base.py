from import_shims.warn import warn_deprecated_import

warn_deprecated_import('instructor_task.tasks_base', 'lms.djangoapps.instructor_task.tasks_base')

from lms.djangoapps.instructor_task.tasks_base import *
