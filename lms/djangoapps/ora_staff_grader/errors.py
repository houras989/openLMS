""" Error codes and exceptions for ESG """
from rest_framework import serializers
from rest_framework.response import Response

from lms.djangoapps.ora_staff_grader.constants import (
    ERR_BAD_ORA_LOCATION,
    ERR_GRADE_CONTESTED,
    ERR_GRADE_SUBMIT,
    ERR_LOCK_CONTESTED,
    ERR_MISSING_PARAM,
    ERR_UNKNOWN,
)


class ExceptionWithContext(Exception):
    """ An exception with optional context dict to be supplied in serialized result """

    def __init__(self, context={}):
        self.context = context


class LockContestedError(ExceptionWithContext):
    """ Signal for trying to operate on a lock owned by someone else """


class ErrorSerializer(serializers.Serializer):
    """Returns error code and unpacks additional context, returns unknown error code if not supplied"""

    error = serializers.CharField(default=ERR_UNKNOWN)

    def to_representation(self, instance):
        """Override to unpack context alongside error code"""
        output = super().to_representation(instance)
        for key, value in self.context.items():
            output[key] = value

        return output


class StaffGraderErrorResponse(Response):
    """An HTTP error response that returns serialized error data with additional provided context"""

    status = 500
    err_code = ERR_UNKNOWN

    def __init__(self, context={}):
        # Unpack provided content into error structure
        content = ErrorSerializer({"error": self.err_code}, context=context).data
        super().__init__(content, status=self.status)


class BadOraLocationResponse(StaffGraderErrorResponse):
    """
    Error response for when the requested ORA_LOCATION could not be found in a course.
    Returns an HTTP 400 with error code.
    """

    status = 400
    err_code = ERR_BAD_ORA_LOCATION


class MissingParamResponse(StaffGraderErrorResponse):
    """
    Error response for when a request is missing a required param/body.
    Returns an HTTP 400 with error code.
    """

    status = 400
    err_code = ERR_MISSING_PARAM


class SubmitGradeErrorResponse(StaffGraderErrorResponse):
    """
    Error response for errors encountered during grade submission (except for grade contest).
    Returns an HTTP 500 with error code and error message from ORA.
    """

    status = 500
    err_code = ERR_GRADE_SUBMIT


class LockContestedResponse(StaffGraderErrorResponse):
    """
    Error response for when a user tries to operate on a submission that they do not have a lock for.
    Returns an HTTP 409 with error code and updated lock status.
    """

    status = 409
    err_code = ERR_LOCK_CONTESTED


class GradeContestedResponse(StaffGraderErrorResponse):
    """
    Error response for when a user tries to operate on a submission that they do not have a lock for.
    Returns an HTTP 409 with error code and updated submission status.
    """

    status = 409
    err_code = ERR_GRADE_CONTESTED


class UnknownErrorResponse(StaffGraderErrorResponse):
    """
    Generic error response for caught but non-standard exception types.
    Returns an HTTP 500 with generic error code.
    """

    status = 500
    err_code = ERR_UNKNOWN
