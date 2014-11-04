"""
Decorators related to edXNotes.
"""
from edxnotes.helpers import (
    get_prefix,
    get_user_id,
    get_username,
    generate_uid,
    get_usage_id,
    get_course_id,
)
from edxmako.shortcuts import render_to_string
from django.conf import settings


def edxnotes(cls):
    """
    Decorator that makes components annotatable.
    """
    original_get_html = cls.get_html

    def get_html(self, *args, **kwargs):
        # edXNotes must be disabled in Studio, returns original method in this case.
        if getattr(self.system, 'is_author_mode', False):
            return original_get_html(self, *args, **kwargs)
        # edXNotes platform-specific feature flag.
        elif not settings.FEATURES.get('ENABLE_EDXNOTES'):
            return original_get_html(self, *args, **kwargs)
        else:
            return render_to_string('edxnotes_wrapper.html', {
                'content': original_get_html(self, *args, **kwargs),
                'uid': generate_uid(),
                'params': {
                    # Use camelCase to name keys.
                    'usageId': get_usage_id(),
                    'courseId': get_course_id(),
                    'prefix': get_prefix(),
                    'user': get_user_id(),
                    'username': get_username(),
                    'debug': settings.DEBUG,
                },
            })

    cls.get_html = get_html
    return cls
