"""Provides factories for student models."""
from student.models import (User, UserProfile, Registration,
                            CourseEnrollmentAllowed, CourseEnrollment,
                            PendingEmailChange, UserStandingConfig,
                            CourseAccessRole)
from course_modes.models import CourseMode
from django.contrib.auth.models import Group, AnonymousUser
from datetime import datetime
import factory
from factory.django import DjangoModelFactory
from uuid import uuid4
from pytz import UTC
from opaque_keys.edx.locations import SlashSeparatedCourseKey

# Factories are self documenting
# pylint: disable=missing-docstring


class GroupFactory(DjangoModelFactory):
    FACTORY_FOR = Group
    FACTORY_DJANGO_GET_OR_CREATE = ('name', )

    name = factory.Sequence(u'group{0}'.format)


class UserStandingFactory(DjangoModelFactory):
    FACTORY_FOR = UserStandingConfig

    disabled = ""


class UserProfileFactory(DjangoModelFactory):
    FACTORY_FOR = UserProfile
    FACTORY_DJANGO_GET_OR_CREATE = ('user', )

    user = None
    name = factory.LazyAttribute(u'{0.user.first_name} {0.user.last_name}'.format)
    level_of_education = None
    gender = u'm'
    mailing_address = None
    goals = u'World domination'


class CourseModeFactory(DjangoModelFactory):
    FACTORY_FOR = CourseMode

    course_id = None
    mode_display_name = u'Honor Code',
    mode_slug = 'honor'
    min_price = 0
    suggested_prices = ''
    currency = 'usd'


class RegistrationFactory(DjangoModelFactory):
    FACTORY_FOR = Registration

    user = None
    activation_key = uuid4().hex.decode('ascii')


class UserFactory(DjangoModelFactory):
    FACTORY_FOR = User
    FACTORY_DJANGO_GET_OR_CREATE = ('email', 'username')

    username = factory.Sequence(u'robot{0}'.format)
    email = factory.Sequence(u'robot+test+{0}@edx.org'.format)
    password = factory.PostGenerationMethodCall('set_password', 'test')
    first_name = factory.Sequence(u'Robot{0}'.format)
    last_name = 'Test'
    is_staff = False
    is_active = True
    is_superuser = False
    last_login = datetime(2012, 1, 1, tzinfo=UTC)
    date_joined = datetime(2011, 1, 1, tzinfo=UTC)

    @factory.post_generation
    def profile(obj, create, extracted, **kwargs):  # pylint: disable=unused-argument, no-self-argument
        if create:
            obj.save()
            return UserProfileFactory.create(user=obj, **kwargs)
        elif kwargs:
            raise Exception("Cannot build a user profile without saving the user")
        else:
            return None

    @factory.post_generation
    def groups(self, create, extracted, **kwargs):
        if extracted is None:
            return

        if isinstance(extracted, basestring):
            extracted = [extracted]

        for group_name in extracted:
            self.groups.add(GroupFactory.simple_generate(create, name=group_name))


class AnonymousUserFactory(factory.Factory):
    FACTORY_FOR = AnonymousUser


class AdminFactory(UserFactory):
    is_staff = True


class CourseEnrollmentFactory(DjangoModelFactory):
    FACTORY_FOR = CourseEnrollment

    user = factory.SubFactory(UserFactory)
    course_id = SlashSeparatedCourseKey('edX', 'toy', '2012_Fall')


class CourseAccessRoleFactory(DjangoModelFactory):
    FACTORY_FOR = CourseAccessRole

    user = factory.SubFactory(UserFactory)
    course_id = SlashSeparatedCourseKey('edX', 'toy', '2012_Fall')
    role = 'TestRole'


class CourseEnrollmentAllowedFactory(DjangoModelFactory):
    FACTORY_FOR = CourseEnrollmentAllowed

    email = 'test@edx.org'
    course_id = SlashSeparatedCourseKey('edX', 'toy', '2012_Fall')


class PendingEmailChangeFactory(DjangoModelFactory):
    """Factory for PendingEmailChange objects

    user: generated by UserFactory
    new_email: sequence of new+email+{}@edx.org
    activation_key: sequence of integers, padded to 30 characters
    """
    FACTORY_FOR = PendingEmailChange

    user = factory.SubFactory(UserFactory)
    new_email = factory.Sequence(u'new+email+{0}@edx.org'.format)
    activation_key = factory.Sequence(u'{:0<30d}'.format)
