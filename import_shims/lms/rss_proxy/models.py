from import_shims.warn import warn_deprecated_import

warn_deprecated_import('rss_proxy.models', 'lms.djangoapps.rss_proxy.models')

from lms.djangoapps.rss_proxy.models import *
