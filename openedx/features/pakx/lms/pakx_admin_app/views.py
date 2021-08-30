"""
Views for Admin Panel API
"""
from itertools import groupby
from uuid import uuid4

from django.conf import settings
from django.contrib.auth.models import Group, User
from django.db.models import Count, ExpressionWrapper, F, IntegerField, Prefetch, Q, Sum
from django.http import Http404
from django.middleware import csrf
from django.utils.decorators import method_decorator
from rest_framework import generics, status, views, viewsets
from rest_framework.authentication import SessionAuthentication
from rest_framework.filters import OrderingFilter
from rest_framework.response import Response

from openedx.core.djangoapps.content.course_overviews.models import CourseOverview
from openedx.core.djangoapps.cors_csrf.decorators import ensure_csrf_cookie_cross_domain
from openedx.core.djangoapps.user_api.accounts.image_helpers import get_profile_image_urls_for_user
from openedx.features.pakx.lms.overrides.models import CourseProgressStats
from student.models import CourseAccessRole, CourseEnrollment, LanguageProficiency

from .constants import (
    ENROLLMENT_COURSE_EXPIRED_MSG,
    ENROLLMENT_SUCCESS_MESSAGE,
    GROUP_ORGANIZATION_ADMIN,
    GROUP_TRAINING_MANAGERS,
    ORG_ADMIN,
    SELF_ACTIVE_STATUS_CHANGE_ERROR_MSG,
    TRAINING_MANAGER
)
from .pagination import CourseEnrollmentPagination, PakxAdminAppPagination
from .permissions import CanAccessPakXAdminPanel, IsSameOrganization
from .serializers import (
    CoursesSerializer,
    CourseStatsListSerializer,
    LearnersSerializer,
    UserCourseEnrollmentSerializer,
    UserDetailViewSerializer,
    UserListingSerializer,
    UserSerializer
)
from .tasks import enroll_users
from .utils import (
    get_available_course_qs,
    get_learners_filter,
    get_org_users_qs,
    get_roles_q_filters,
    get_user_org_filter,
    send_registration_email
)

COMPLETED_COURSE_COUNT = Count("courseenrollment", filter=Q(
    courseenrollment__enrollment_stats__email_reminder_status=CourseProgressStats.COURSE_COMPLETED))
IN_PROGRESS_COURSE_COUNT = Count("courseenrollment", filter=Q(
    courseenrollment__enrollment_stats__email_reminder_status__lt=CourseProgressStats.COURSE_COMPLETED))


class UserCourseEnrollmentsListAPI(generics.ListAPIView):
    """
    List API of user course enrollment
    <lms>/adminpanel/user-course-enrollments/<user_id>/

    :returns:
        {
            "count": 3,
            "next": null,
            "previous": null,
            "results": [
                {
                    "display_name": "Rohan's Practice Course",
                    "enrollment_status": "honor",
                    "enrollment_date": "2021-06-10",
                    "progress": 33.0,
                    "completion_date": null,
                    "grades": ""
                },
                {
                    "display_name": "کام کی جگہ کے آداب",
                    "enrollment_status": "honor",
                    "enrollment_date": "2021-06-09",
                    "progress": 33.0,
                    "completion_date": null,
                    "grades": ""
                }
            ],
            "total_pages": 1
        }

    """
    serializer_class = UserCourseEnrollmentSerializer
    authentication_classes = [SessionAuthentication]
    permission_classes = [CanAccessPakXAdminPanel, IsSameOrganization]
    pagination_class = CourseEnrollmentPagination
    model = CourseEnrollment

    def get_queryset(self):
        return CourseEnrollment.objects.filter(
            user_id=self.kwargs['user_id'], is_active=True
        ).select_related(
            'enrollment_stats',
            'course'
        ).order_by(
            '-id'
        )

    def get_serializer_context(self):
        context = super(UserCourseEnrollmentsListAPI, self).get_serializer_context()
        context.update({'request': self.request})
        return context


class UserProfileViewSet(viewsets.ModelViewSet):
    """
    User view-set for user listing/create/update/active/de-active
    """
    authentication_classes = [SessionAuthentication]
    permission_classes = [CanAccessPakXAdminPanel]
    pagination_class = PakxAdminAppPagination
    serializer_class = UserListingSerializer
    filter_backends = [OrderingFilter]
    OrderingFilter.ordering_fields = ('id', 'name', 'email', 'employee_id')
    ordering = ['-id']

    def get_object(self):
        group_qs = Group.objects.filter(name__in=[GROUP_TRAINING_MANAGERS, GROUP_ORGANIZATION_ADMIN]).order_by('name')
        user_qs = User.objects.all()
        if not self.request.user.is_superuser:
            user_qs = user_qs.filter(**get_user_org_filter(self.request.user))

        user_obj = user_qs.filter(
            id=self.kwargs['pk']
        ).select_related(
            'profile'
        ).prefetch_related(
            'courseenrollment_set'
        ).prefetch_related(
            Prefetch('groups', to_attr='staff_groups', queryset=group_qs),
        ).annotate(
            completed=COMPLETED_COURSE_COUNT,
            in_prog=IN_PROGRESS_COURSE_COUNT).first()

        if user_obj:
            return user_obj
        raise Http404

    def get_serializer_class(self):
        if self.action in ['retrieve', 'partial_update']:
            return UserDetailViewSerializer

        return UserListingSerializer

    def create(self, request, *args, **kwargs):
        if request.data.get('profile'):
            request.data['profile']['organization'] = self.request.user.profile.organization_id
        password = uuid4().hex[:8]
        request.data['password'] = password
        user_serializer = UserSerializer(data=request.data)
        if user_serializer.is_valid():
            user = user_serializer.save()
            send_registration_email(user, password, request.scheme)
            return Response(UserSerializer(user).data, status=status.HTTP_201_CREATED)

        return Response({**user_serializer.errors}, status=status.HTTP_400_BAD_REQUEST)

    def partial_update(self, request, *args, **kwargs):
        user = self.get_object()
        request.data['profile'].update({'organization': self.request.user.profile.organization_id})
        user_serializer = UserSerializer(user, data=request.data, partial=True)

        if user_serializer.is_valid():
            user_serializer.save()
            return Response(self.get_serializer(user).data, status=status.HTTP_200_OK)

        return Response(user_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def destroy(self, request, *args, **kwargs):
        if request.user.id == kwargs['pk']:
            return Response(SELF_ACTIVE_STATUS_CHANGE_ERROR_MSG, status=status.HTTP_403_FORBIDDEN)

        if self.get_queryset().filter(id=kwargs['pk']).update(is_active=False):
            return Response(status=status.HTTP_200_OK)

        return Response({"ID not found": kwargs['pk']}, status=status.HTTP_404_NOT_FOUND)

    def list(self, request, *args, **kwargs):
        self.queryset = self.get_queryset()
        total_users_count = self.get_queryset().count()

        roles = self.request.query_params['roles'].split(',') if self.request.query_params.get('roles') else []
        roles_qs = get_roles_q_filters(roles)
        if roles_qs:
            self.queryset = self.queryset.filter(roles_qs)

        username = self.request.query_params['username'] if self.request.query_params.get('username') else None
        if username:
            self.queryset = self.queryset.filter(username=username)

        languages = self.request.query_params['languages'].split(',') if self.request.query_params.get(
            'languages') else []

        if languages:
            self.queryset = self.queryset.filter(profile__language_proficiencies__code__in=languages)

        search = self.request.query_params.get('search', '').strip().lower()
        for s_text in search.split():
            self.queryset = self.queryset.filter(Q(profile__name__icontains=s_text) | Q(email__icontains=s_text))

        page = self.paginate_queryset(self.queryset)
        response_data = {'total_users_count': total_users_count}

        if page is not None:
            response_data['users'] = self.get_serializer(page, many=True).data
            return self.get_paginated_response(response_data)

        response_data['users'] = self.get_serializer(self.queryset, many=True).data
        return Response(response_data)

    def get_queryset(self):
        if self.request.query_params.get("ordering"):
            self.ordering = self.request.query_params['ordering'].split(',') + self.ordering

        queryset = get_org_users_qs(self.request.user).exclude(id=self.request.user.id)
        group_qs = Group.objects.filter(name__in=[GROUP_TRAINING_MANAGERS, GROUP_ORGANIZATION_ADMIN]).order_by('name')
        return queryset.select_related(
            'profile'
        ).prefetch_related(
            Prefetch('groups', to_attr='staff_groups', queryset=group_qs),
        ).annotate(
            employee_id=F('profile__employee_id'), name=F('first_name')
        ).order_by(
            *self.ordering
        ).distinct()

    def activate_users(self, request, *args, **kwargs):
        return self.change_activation_status(True, request.data["ids"])

    def deactivate_users(self, request, *args, **kwargs):
        return self.change_activation_status(False, request.data["ids"])

    def change_activation_status(self, activation_status, ids):
        """
        method to change user activation status for given user IDs
        :param activation_status: new boolean active status
        :param ids: user IDs to be updated
        :return: response with respective status
        """
        if [str(self.request.user.id)] == ids:
            return Response(SELF_ACTIVE_STATUS_CHANGE_ERROR_MSG, status=status.HTTP_403_FORBIDDEN)

        if ids == "all":
            self.get_queryset().all().update(is_active=activation_status)
            return Response(status=status.HTTP_200_OK)

        if self.get_queryset().filter(id__in=ids).update(is_active=activation_status):
            return Response(status=status.HTTP_200_OK)

        return Response(status=status.HTTP_404_NOT_FOUND)


class CourseEnrolmentViewSet(viewsets.ModelViewSet):
    """
    Course view-set for bulk enrolment task
    """
    authentication_classes = [SessionAuthentication]
    permission_classes = [CanAccessPakXAdminPanel]

    def enroll_users(self, request, *args, **kwargs):
        available_courses_count = CourseOverview.objects.filter(
            get_available_course_qs(),
            id__in=request.data["course_keys"],
        ).count()
        if available_courses_count != len(request.data["course_keys"]):
            return Response(ENROLLMENT_COURSE_EXPIRED_MSG, status=status.HTTP_400_BAD_REQUEST)

        user_qs = get_org_users_qs(request.user).filter(id__in=request.data["user_ids"]).values_list('id', flat=True)
        if not request.data.get("user_ids") or not request.data.get("course_keys"):
            return Response(
                "Invalid request data! User IDs and course keys are required",
                status=status.HTTP_400_BAD_REQUEST
            )

        if len(request.data["user_ids"]) != len(user_qs):
            other_org_users = list(set(request.data["user_ids"]) - set(list(user_qs)))
            err_msg = "You don't have the permission for {} requested users".format(len(other_org_users))
            return Response(data={'users': other_org_users, 'message': err_msg}, status=status.HTTP_409_CONFLICT)

        enroll_users.delay(self.request.user.id, request.data["user_ids"], request.data["course_keys"])
        return Response(ENROLLMENT_SUCCESS_MESSAGE, status=status.HTTP_200_OK)


class AnalyticsStats(views.APIView):
    """
    API view for organization level analytics stats
    <lms>/adminpanel/analytics/stats/

    :return:
        {
            "completed_course_count": 1,
            "course_assignment_count": 7,
            "course_in_progress": 6,
            "learner_count": 4
        }
    """
    authentication_classes = [SessionAuthentication]
    permission_classes = [CanAccessPakXAdminPanel]

    def get(self, *args, **kwargs):  # pylint: disable=unused-argument
        """
        get analytics quick stats about learner and their assigned courses
        """
        user_qs = get_org_users_qs(self.request.user)
        user_ids = user_qs.values_list('id', flat=True)
        course_stats = user_qs.annotate(passed=ExpressionWrapper(COMPLETED_COURSE_COUNT,
                                                                 output_field=IntegerField()),
                                        in_progress=ExpressionWrapper(
                                            IN_PROGRESS_COURSE_COUNT, output_field=IntegerField())).aggregate(
            completions=Sum(F('passed')), pending=Sum(F('in_progress')))
        data = {'learner_count': len(user_ids), 'course_in_progress': course_stats.get('pending', 0),
                'completed_course_count': course_stats.get('completions', 0)}

        data['course_assignment_count'] = data['course_in_progress'] + data['completed_course_count']
        return Response(status=status.HTTP_200_OK, data=data)


class CourseStatsListAPI(generics.ListAPIView):
    """
    API view for learners list
    <lms>/adminpanel/courses/stats/
    :returns
        [
            {
                "display_name": "Preventing Workplace Harassment",
                "enrolled": 2,
                "completed": 1,
                "in_progress": 1,
                "completion_rate": 50
            },
            {
                "display_name": "Demonstration Course",
                "enrolled": 2,
                "completed": 0,
                "in_progress": 2,
                "completion_rate": 0
            },
            {
                "display_name": "E2E Test Course",
                "enrolled": 0,
                "completed": 0,
                "in_progress": 0,
                "completion_rate": 0
            }
        ]
    """

    authentication_classes = [SessionAuthentication]
    permission_classes = [CanAccessPakXAdminPanel]
    pagination_class = None
    queryset = CourseOverview.objects.all()
    serializer_class = CourseStatsListSerializer

    def get_queryset(self):
        return CourseOverview.objects.all().annotate(
            in_progress=IN_PROGRESS_COURSE_COUNT,
            completed=COMPLETED_COURSE_COUNT
        )


class LearnerListAPI(generics.ListAPIView):
    """
    API view for learners list
    <lms>/adminpanel/analytics/learners/

    :returns:
    {
        "count": 4,
        "next": null,
        "previous": null,
        "results": [
            {
                "id": 5,
                "name": "",
                "email": "honor@example.com",
                "last_login": "2021-06-22T05:39:30.818097Z",
                "assigned_courses": 2,
                "incomplete_courses": 1,
                "completed_courses": 1
            },
            {
                "id": 7,
                "name": "",
                "email": "verified@example.com",
                "last_login": null,
                "assigned_courses": 1,
                "incomplete_courses": 1,
                "completed_courses": 0
            }
        ]
    }
    """

    authentication_classes = [SessionAuthentication]
    permission_classes = [CanAccessPakXAdminPanel]
    pagination_class = PakxAdminAppPagination
    serializer_class = LearnersSerializer

    def get_queryset(self):
        user_qs = User.objects.filter(get_learners_filter())
        if not self.request.user.is_superuser:
            user_qs = user_qs.filter(**get_user_org_filter(self.request.user))

        enrollments = CourseEnrollment.objects.filter(is_active=True).select_related('enrollment_stats')
        return user_qs.prefetch_related(
            Prefetch('courseenrollment_set', to_attr='enrollment', queryset=enrollments)
        )


class UserInfo(views.APIView):
    """
    API for basic user information
    """
    authentication_classes = [SessionAuthentication]
    permission_classes = [CanAccessPakXAdminPanel]

    @method_decorator(ensure_csrf_cookie_cross_domain)
    def get(self, *args, **kwargs):  # pylint: disable=unused-argument
        """
        get user's basic info
        """
        if self.request.user.is_superuser:
            languages_qs = LanguageProficiency.objects.all()
        else:
            languages_qs = LanguageProficiency.objects.filter(
                user_profile__organization=self.request.user.profile.organization_id
            )
        all_languages = [{'code': lang[0], 'value': lang[1]} for lang in settings.ALL_LANGUAGES]
        languages = [{'code': lang.code, 'value': lang.get_code_display()} for lang in languages_qs]
        profile_image = get_profile_image_urls_for_user(self.request.user)['medium']

        user_info = {
            'profile_image': profile_image,
            'name': self.request.user.profile.name,
            'username': self.request.user.username,
            'is_superuser': self.request.user.is_superuser,
            'id': self.request.user.id,
            'csrf_token': csrf.get_token(self.request),
            'languages': [lang[0] for lang in groupby(languages)],
            'all_languages': all_languages,
            'role': None
        }
        user_groups = Group.objects.filter(
            user=self.request.user, name__in=[GROUP_TRAINING_MANAGERS, GROUP_ORGANIZATION_ADMIN]
        ).order_by('name').first()
        if user_groups:
            user_info['role'] = TRAINING_MANAGER if user_groups.name == GROUP_TRAINING_MANAGERS else ORG_ADMIN

        return Response(status=status.HTTP_200_OK, data=user_info)


class CourseListAPI(generics.ListAPIView):
    authentication_classes = [SessionAuthentication]
    permission_classes = [CanAccessPakXAdminPanel]
    pagination_class = PakxAdminAppPagination
    serializer_class = CoursesSerializer

    PakxAdminAppPagination.page_size = 5

    instructors = {}

    def get_serializer_context(self):
        context = super(CourseListAPI, self).get_serializer_context()
        context.update({"instructors": self.instructors})
        return context

    def get_queryset(self):
        queryset = CourseOverview.objects.filter(get_available_course_qs())

        user_id = self.request.query_params.get('user_id', '').strip().lower()
        if user_id:
            queryset = queryset.exclude(courseenrollment__user_id=user_id, courseenrollment__is_active=True)

        search_text = self.request.query_params.get('name', '').strip().lower()
        if search_text:
            queryset = queryset.filter(display_name__icontains=search_text)

        course_access_role_qs = CourseAccessRole.objects.filter(
            course_id__in=queryset.values_list('id')
        ).select_related(
            'user__profile'
        )

        for course_access_role in course_access_role_qs:
            course_instructors = self.instructors.get(course_access_role.course_id, [])
            instructor_name = course_access_role.user.profile.name or course_access_role.user.username
            if instructor_name not in course_instructors:
                course_instructors.append(instructor_name)
            self.instructors[course_access_role.course_id] = course_instructors

        return queryset
