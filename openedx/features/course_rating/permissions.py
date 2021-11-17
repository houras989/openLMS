"""
Custom permissions for course rating app.
"""
from django.conf import settings
from rest_framework import permissions

from openedx.features.course_rating.models import CourseRating


class CustomCourseRatingPermission(permissions.BasePermission):
    """
    Custom permission for course rating.
    """

    def has_permission(self, request, view):
        """
        Custom permission to only allow super user or owners of a course rating to modify it.
        """

        if request.method == 'GET':
            return True

        elif request.method in ['POST']:
            return request.user.is_authenticated

        elif request.method in ['PUT', 'PATCH', 'DELETE']:
            obj = CourseRating.objects.get(pk=view.kwargs['pk'])
            if obj is not None:
                return (request.user.is_superuser or obj.user == request.user or
                        request.user.groups.filter(name=settings.EDLY_WP_ADMIN_USERS_GROUP).exists())
