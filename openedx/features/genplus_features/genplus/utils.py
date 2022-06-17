from django.conf import settings


def override_next_url(strategy, response, *args, **kwargs):
    strategy.session_set('next', settings.GENPLUS_FRONTEND_URL)
