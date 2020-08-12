"""
Context dictionary for templates that use the ace_common base template.
"""


from django.conf import settings
from django.urls import NoReverseMatch, reverse

from edxmako.shortcuts import marketing_link
from branding import api as branding_api
from openedx.core.djangoapps.theming.helpers import get_config_value_from_site_or_settings


def get_base_template_context(site):
    """
    Dict with entries needed for all templates that use the base template.
    """
    # When on LMS and a dashboard is available, use that as the dashboard url.
    # Otherwise, use the home url instead.
    try:
        dashboard_url = reverse('dashboard')
    except NoReverseMatch:
        dashboard_url = reverse('home')

    logo_image_url = None
    if settings.ENABLE_COMPREHENSIVE_THEMING:
        logo_image_url = branding_api.get_logo_url()

    return {
        # Platform information
        'homepage_url': marketing_link('ROOT'),
        'dashboard_url': dashboard_url,
        'logo_image_url': logo_image_url,
        'template_revision': getattr(settings, 'EDX_PLATFORM_REVISION', None),
        'platform_name': get_config_value_from_site_or_settings(
            'PLATFORM_NAME',
            site=site,
            site_config_name='platform_name',
        ),
        'contact_email': get_config_value_from_site_or_settings(
            'CONTACT_EMAIL', site=site, site_config_name='contact_email'),
        'contact_mailing_address': get_config_value_from_site_or_settings(
            'CONTACT_MAILING_ADDRESS', site=site, site_config_name='contact_mailing_address'),
        'social_media_urls': get_config_value_from_site_or_settings('SOCIAL_MEDIA_FOOTER_URLS', site=site),
        'mobile_store_urls': get_config_value_from_site_or_settings('MOBILE_STORE_URLS', site=site),
    }
