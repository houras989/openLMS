"""
Client for Sending Emails with HubSpot.
"""
import logging

import requests
from django.conf import settings


logger = logging.getLogger(__name__)


class HubSpotClient:
    """
    HubSpot Client
    """

    ACCOUNT_ACTIVATION_EMAIL = '74553115138'
    PASSWORD_RESET_EMAIL = '74589854319'
    PASSWORD_RESET_COMPLETE = '74591235508'
    COURSE_COMPLETION = '74600305296'
    SELF_PACED_COURSE_ENROLLMENT_EMAIL = '74616750411'
    CERTIFICATE_READY_TO_DOWNLOAD = '74613102189'
    ORG_ADMIN_ACTIVATION = '75041803894'
    ORG_ADMIN_CHANGE = '75041806097'
    ORG_ADMIN_GET_IN_TOUCH = '75043535449'
    ORG_NEW_ADMIN_GET_IN_TOUCH = '75043537509'
    ORG_ADMIN_CLAIM_CONFIRMATION = '75045046898'
    ORG_NEW_ADMIN_CLAIM_CONFIRMATION = '75045048203'
    INSTRUCTOR_PACED_COURSE_ENROLLMENT_EMAIL = '75069983596'
    MINI_COURSE_ENROLMENT = '75071035512'
    COURSE_WELCOME_EMAIL_NOTIFICATION = '75167423112'
    COURSE_WEEK_BEFORE_REMINDER = '75175096445'
    COURSE_TWO_DAYS_BEFORE_REMINDER = '75175904657'
    COURSE_INVITATION_NON_REGISTERED_USERS = '75178006321'
    COURSE_ACTIVATION_REMINDER_NON_ACTIVE_USERS = '75178009772'
    ON_DEMAND_COURSE_WEEKLY_MODULE_COMPLETE = '75178889565'
    ON_DEMAND_WEEKLY_MODULE_SKIPPED_TEMPLATE = '75184805507'
    ON_DEMAND_REMINDER_EMAIL_TEMPLATE = '75185593206'
    VERIFY_CHANGE_USER_EMAIL = '75249521070'
    CHANGE_USER_EMAIL_ALERT = '75249920384'
    USER_NEW_BADGE_EMAIL = '75250596687'
    REFERRAL_INITIAL_EMAIL = '75250597036'
    REFERRAL_SOCIAL_IMPACT_TOOLKIT = '75249921897'
    REFERRAL_FOLLOW_UP_EMAIL = '75249523372'

    def __init__(self):
        """
        Initialize HubSpot Client.
        """
        self.api_key = settings.HUBSPOT_API_KEY
        self.HUBSPOT_API_URL = 'https://api.hubapi.com'

    def send_mail(self, email_data):
        """
        Sends POST request to HubSpot API to send an email.

        Arguments:
            email_data (dict): Contains hubspot post data.
        """
        logger.info('Sending Email With HubSpot, Email Data: {email_data}'.format(email_data=email_data))

        url = '{hubspot_api_url}/marketing/v3/transactional/single-email/send?hapikey={api_key}'.format(
            hubspot_api_url=self.HUBSPOT_API_URL,
            api_key=self.api_key
        )
        headers = {'Content-type': 'application/json'}
        response = requests.post(url, headers=headers, json=email_data)

        logger.info(response.json())
        return response

    def create_contact(self, user_json):
        """
        Create new contact on HubSpot.

        Arguments:
            user_json (dict): User data.
        """
        logger.info('Creating HubSpot contact, Data: {user_json}'.format(user_json=user_json))

        url = '{hubspot_api_url}/crm/v3/objects/contacts?hapikey={api_key}'.format(
            hubspot_api_url=self.HUBSPOT_API_URL,
            api_key=self.api_key
        )
        headers = {'Content-type': 'application/json'}
        response = requests.post(url, headers=headers, json=user_json)

        logger.info(response.json())
        return response

    def update_contact(self, user, user_json):
        """
        Update contact on HubSpot.

        Arguments:
            user_json (dict): User data.
            user (User): User object.
        """
        logger.info(
            'Updating HubSpot contact, User: {user} & Data: {user_json}'.format(user=user, user_json=user_json)
        )

        url = '{hubspot_api_url}/crm/v3/objects/contacts/{contact_id}?hapikey={api_key}'.format(
            hubspot_api_url=self.HUBSPOT_API_URL,
            api_key=self.api_key,
            contact_id=user.extended_profile.hubspot_contact_id
        )
        headers = {'Content-type': 'application/json'}
        response = requests.patch(url, headers=headers, json=user_json)

        if response.status_code == 200:
            logger.info('Contact Updated Successfully!')
        else:
            logger.exception(
                'Could not Update HubSpot Contact, Status Code: {status_code}'.format(status_code=response.status_code)
            )

        logger.info(response.json())
        return response
