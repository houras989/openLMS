# -*- coding: utf-8 -*-
"""
Django model specifications for the Program Enrollments API
"""


from django.contrib.auth.models import User
from django.core.exceptions import ValidationError
from django.db import models
from django.utils.translation import ugettext_lazy as _
from model_utils.models import TimeStampedModel
from opaque_keys.edx.django.models import CourseKeyField
from simple_history.models import HistoricalRecords

from student.models import CourseEnrollment
from student.roles import CourseStaffRole

from .constants import ProgramCourseEnrollmentRoles, ProgramCourseEnrollmentStatuses, ProgramEnrollmentStatuses


class ProgramEnrollment(TimeStampedModel):
    """
    This is a model for Program Enrollments from the registrar service

    .. pii: PII is found in the external key for a program enrollment
    .. pii_types: other
    .. pii_retirement: local_api
    """
    STATUS_CHOICES = ProgramEnrollmentStatuses.__MODEL_CHOICES__

    class Meta(object):
        app_label = "program_enrollments"

        # A student enrolled in a given (program, curriculum) should always
        # have a non-null ``user`` or ``external_user_key`` field (or both).
        unique_together = (
            ('user', 'program_uuid', 'curriculum_uuid'),
            ('external_user_key', 'program_uuid', 'curriculum_uuid'),
        )

    user = models.ForeignKey(
        User,
        null=True,
        blank=True, on_delete=models.CASCADE
    )
    external_user_key = models.CharField(
        db_index=True,
        max_length=255,
        null=True
    )
    program_uuid = models.UUIDField(db_index=True, null=False)
    curriculum_uuid = models.UUIDField(db_index=True, null=False)
    status = models.CharField(max_length=9, choices=STATUS_CHOICES)
    historical_records = HistoricalRecords()

    def clean(self):
        if not (self.user or self.external_user_key):
            raise ValidationError(_('One of user or external_user_key must not be null.'))

    @classmethod
    def retire_user(cls, user_id):
        """
        With the parameter user_id, retire the external_user_key field

        Return True if there is data that was retired
        Return False if there is no matching data
        """

        enrollments = cls.objects.filter(user=user_id)
        if not enrollments:
            return False

        for enrollment in enrollments:
            enrollment.historical_records.update(external_user_key=None)

        enrollments.update(external_user_key=None)
        return True

    def __str__(self):
        return '[ProgramEnrollment id={}]'.format(self.id)

    def __repr__(self):
        return (
            "<ProgramEnrollment"    # pylint: disable=missing-format-attribute
            " id={self.id}"
            " user={self.user!r}"
            " external_user_key={self.external_user_key!r}"
            " program_uuid={self.program_uuid!r}"
            " curriculum_uuid={self.curriculum_uuid!r}"
            " status={self.status!r}"
            ">"
        ).format(self=self)


class ProgramCourseEnrollment(TimeStampedModel):
    """
    This is a model to represent a learner's enrollment in a course
    in the context of a program from the registrar service

    .. no_pii:
    """
    STATUS_CHOICES = ProgramCourseEnrollmentStatuses.__MODEL_CHOICES__

    class Meta(object):
        app_label = "program_enrollments"

        # For each program enrollment, there may be only one
        # waiting program-course enrollment per course key.
        # This same constraint is implicitly enforced for
        # completed program-course enrollments by the
        # OneToOneField on `course_enrollment`, which mandates that
        # there may be at most one program-course enrollment per
        # (user, course) pair.
        unique_together = (
            ('program_enrollment', 'course_key'),
        )

    program_enrollment = models.ForeignKey(
        ProgramEnrollment,
        on_delete=models.CASCADE,
        related_name="program_course_enrollments"
    )
    # In Django 2.x, we should add a conditional unique constraint to this field so
    # no duplicated tuple of (course_enrollment_id, status=active) exists
    # MST-168 is the Jira ticket to accomplish this once Django is upgraded
    course_enrollment = models.ForeignKey(
        CourseEnrollment,
        null=True,
        blank=True,
        on_delete=models.CASCADE
    )
    course_key = CourseKeyField(max_length=255)
    status = models.CharField(max_length=9, choices=STATUS_CHOICES)
    historical_records = HistoricalRecords()

    @property
    def is_active(self):
        return self.status == ProgramCourseEnrollmentStatuses.ACTIVE

    @property
    def course_staff(self):
        role_assignment_exists = CourseAccessRoleAssignment.objects.filter(
            enrollment=self,
            role=ProgramCourseEnrollmentRoles.COURSE_STAFF,
        ).exists()
        if role_assignment_exists:
            return True
        elif self.program_enrollment.user:
            return CourseStaffRole(self.course_key).has_user(self.program_enrollment.user)
        return False

    def __str__(self):
        return '[ProgramCourseEnrollment id={}]'.format(self.id)

    def __repr__(self):
        return (
            "<ProgramCourseEnrollment"  # pylint: disable=missing-format-attribute
            " id={self.id}"
            " program_enrollment={self.program_enrollment!r}"
            " course_enrollment=<{self.course_enrollment}>"
            " course_key={self.course_key}"
            " status={self.status!r}"
            ">"
        ).format(self=self)


class CourseAccessRoleAssignment(TimeStampedModel):
    """
    This model represents a role that should be assigned to the eventual user of a pending enrollment.

    .. no_pii:
    """
    class Meta(object):
        unique_together = ('role', 'enrollment')

    role = models.CharField(max_length=64, choices=ProgramCourseEnrollmentRoles.__MODEL_CHOICES__)
    enrollment = models.ForeignKey(ProgramCourseEnrollment, on_delete=models.CASCADE)

    def __str__(self):
        return '[CourseAccessRoleAssignment id={}]'.format(self.id)

    def __repr__(self):
        return (
            "<CourseAccessRoleAssignment"  # pylint: disable=missing-format-attribute
            " id={self.id}"
            " role={self.role!r}"
            " enrollment={self.enrollment!r}"
            ">"
        ).format(self=self)
