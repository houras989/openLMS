from import_shims.warn import warn_deprecated_import

warn_deprecated_import('certificates.tests', 'lms.djangoapps.certificates.tests')

from lms.djangoapps.certificates.tests import *
