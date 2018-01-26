import mandrill
import logging

from django.conf import settings

log = logging.getLogger(__name__)

class MandrillClient(object):
    PASSWORD_RESET_TEMPLATE = 'template-60'
    USER_ACCOUNT_ACTIVATION_TEMPLATE = 'template-61'
    ORG_ADMIN_ACTIVATION_TEMPLATE = 'template-62'
    ENROLLMENT_CONFIRMATION_TEMPLATE = 'enrollment-confirmation'
    COURSE_WELCOME_TEMPLATE = 'course_welcome'
    COURSE_EARLY_WELCOME_TEMPLATE = 'course-early-welcome'
    COURSE_START_REMINDER_TEMPLATE = 'course-start-reminder'
    COURSE_COMPLETION_TEMPLATE = 'course-completion'
    WEEKLY_TEMPLATE = 'weekly'

    def __init__(self):
        self.mandrill_client = mandrill.Mandrill(settings.MANDRILL_API_KEY)

    def send_mail(self, template_name, user_email, context):
        """
        calls the mandrill API for the specific template and email

        arguments:
        template_name: the slug/identifier of the mandrill email template
        user_email: the email of the receiver
        context: the data which is passed to the template. must be a dict
        """
        global_merge_vars = [{'name': key, 'content': context[key]} for key in context]

        try:
            result = self.mandrill_client.messages.send_template(
                template_name=template_name,
                template_content=[],
                message={
                    'from_email': settings.NOTIFICATION_FROM_EMAIL,
                    'to': [{ 'email': user_email }],
                    'global_merge_vars': global_merge_vars
                },
            )
            log.info(result)
        except mandrill.Error, e:
            # Mandrill errors are thrown as exceptions
            log.error('A mandrill error occurred: %s - %s' % (e.__class__, e))
            raise
        return result

