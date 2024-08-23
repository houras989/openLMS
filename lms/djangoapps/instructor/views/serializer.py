""" Instructor apis serializers. """

from django.contrib.auth.models import User  # lint-amnesty, pylint: disable=imported-auth-user
from django.core.exceptions import ValidationError
from django.utils.translation import gettext as _
from rest_framework import serializers
from .tools import get_student_from_identifier

from lms.djangoapps.instructor.access import ROLES


class RoleNameSerializer(serializers.Serializer):  # pylint: disable=abstract-method
    """
    Serializer that describes the response of the problem response report generation API.
    """

    rolename = serializers.CharField(help_text=_("Role name"))

    def validate_rolename(self, value):
        """
        Check that the rolename is valid.
        """
        if value not in ROLES:
            raise ValidationError(_("Invalid role name."))
        return value


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['username', 'email', 'first_name', 'last_name']


class AccessSerializer(serializers.Serializer):
    """
    Serializer for managing user access changes.
    This serializer validates and processes the data required to modify
    user access within a system.
    """
    unique_student_identifier = serializers.CharField(
        max_length=255,
        help_text="Email or username of user to change access"
    )
    rolename = serializers.CharField(
        help_text="Role name to assign to the user"
    )
    action = serializers.ChoiceField(
        choices=['allow', 'revoke'],
        help_text="Action to perform on the user's access"
    )

    def validate_unique_student_identifier(self, value):
        """
        Validate that the unique_student_identifier corresponds to an existing user.
        """
        try:
            user = get_student_from_identifier(value)
        except User.DoesNotExist:
            return None

        return user


class ListInstructorSerializer(serializers.Serializer):  # pylint: disable=abstract-method
    """
    Serializer for handling the input data for the problem response report generation API.

Attributes:
    unique_student_identifier (str): The email or username of the student.
                                      This field is optional, but if provided, the `problem_location_str`
                                      must also be provided.
    problem_location_str (str): The string representing the location of the problem within the course.
                                This field is optional, unless `unique_student_identifier` is provided.
    """
    unique_student_identifier = serializers.CharField(
        max_length=255,
        help_text="Email or username of student",
        required=False
    )
    problem_location_str = serializers.CharField(
        help_text="Problem location",
        required=False
    )

    def validate(self, data):
        """
        Validate the data to ensure that if unique_student_identifier is provided,
        problem_location_str must also be provided.
        """
        unique_student_identifier = data.get('unique_student_identifier')
        problem_location_str = data.get('problem_location_str')

        if unique_student_identifier and not problem_location_str:
            raise serializers.ValidationError(
                "unique_student_identifier must accompany problem_location_str"
            )

        return data
