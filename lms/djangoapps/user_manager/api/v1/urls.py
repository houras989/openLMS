"""
user manager API URLs
"""
from django.conf import settings
from django.conf.urls import url

from . import views

urlpatterns = [
    # Get list of all managers
    url(
        r'^managers/$',
        views.ManagerListView.as_view(),
        name='manager-list',
    ),
    # List managers for a specified user
    url(
        r'^managers/{}/$'.format(settings.USERNAME_PATTERN),
        views.UserManagerListView.as_view(),
        name='user-managers-list',
    ),
    # Get or add direct reports of specified manager
    url(
        r'^reports/{}/$'.format(settings.USERNAME_PATTERN),
        views.ManagerReportsListView.as_view(),
        name='manager-direct-reports-list',
    ),
]
