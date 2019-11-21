from django.conf import settings
from django.conf.urls import url

from openedx.features.courseware.views import pre_post_assessments_score_view


urlpatterns = [
    url(r'^api/courses/{}/courseware/(?P<chapter_id>[^/]*)/pre_post_assessments_score/$'.
        format(settings.COURSE_ID_PATTERN), pre_post_assessments_score_view,
        name='pre_post_assessments_score')
]
