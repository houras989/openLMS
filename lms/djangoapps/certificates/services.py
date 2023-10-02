"""
Certificate service
"""

from lms.djangoapps.certificates.api import invalidate_certificate_legacy_and_new


class CertificateService:
    """
    User Certificate service
    """

    def invalidate_certificate(self, user_id, course_key_or_id):
        # The original code for this function was moved to this helper function to be call-able
        # By both the legacy and current exams backends (edx-proctoring and edx-exams).
        return invalidate_certificate_legacy_and_new(user_id, course_key_or_id)
