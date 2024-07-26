"""Contenstore API v2 URLs."""

from django.conf import settings
from django.urls import path, re_path

from cms.djangoapps.contentstore.rest_api.v2.views import (
    HomePageCoursesViewV2,
    UpstreamSyncView,
)

app_name = "v2"

urlpatterns = [
    path(
        "home/courses",
        HomePageCoursesViewV2.as_view(),
        name="courses",
    ),
    re_path(
        fr'^upstream_sync/{settings.USAGE_KEY_PATTERN}$',
        UpstreamSyncView.as_view(),
        name="upstream_sync"
    ),
]
