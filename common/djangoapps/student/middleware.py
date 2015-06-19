"""
Middleware that checks user standing for the purpose of keeping users with
disabled accounts from accessing the site.
"""
from django.http import HttpResponseForbidden
from django.utils.translation import ugettext as _
from django.conf import settings
from student.models import UserStandingConfig


class UserStandingMiddleware(object):
    """
    Checks a user's standing on request. Returns a 403 if the user's
    status is 'disabled'.
    """
    def process_request(self, request):
        user = request.user
        if user.username in UserStandingConfig.current().disabled_list:
            msg = _(
                'Your account has been disabled. If you believe '
                'this was done in error, please contact us at '
                '{support_email}'
            ).format(
                support_email=u'<a href="mailto:{address}?subject={subject_line}">{address}</a>'.format(
                    address=settings.DEFAULT_FEEDBACK_EMAIL,
                    subject_line=_('Disabled Account'),
                ),
            )
            return HttpResponseForbidden(msg)
