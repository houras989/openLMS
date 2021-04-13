"""
Tests for all the helpers in webinars app
"""
import pytest

from common.djangoapps.student.tests.factories import UserFactory
from openedx.adg.common.lib.mandrill_client.client import MandrillClient
from openedx.adg.lms.webinars.helpers import send_cancellation_emails_for_given_webinars

from .factories import WebinarFactory, WebinarRegistrationFactory


@pytest.mark.django_db
@pytest.mark.parametrize(
    'registered_users_with_response, cohosts, panelists, presenter, expected_email_addresses',
    [
        (
            [], [], [], 't3@eg.com', ['t3@eg.com']
        ),
        (
            [('t1@eg.com', False), ('t2@eg.com', False)], [], [], 't3@eg.com', ['t3@eg.com']
        ),
        (
            [('t1@eg.com', True), ('t2@eg.com', False)], ['t1@eg.com'], [], 't3@eg.com', ['t1@eg.com', 't3@eg.com']
        ),
        (
            [('t1@eg.com', False), ('t2@eg.com', True)], [], ['t2@eg.com'], 't3@eg.com', ['t2@eg.com', 't3@eg.com']
        ),
        (
            [('t1@eg.com', False), ('t2@eg.com', False)], ['t1@eg.com'], ['t2@eg.com'], 't3@eg.com',
            ['t1@eg.com', 't2@eg.com', 't3@eg.com']
        ),
        (
            [('t1@eg.com', True), ('t2@eg.com', True)], ['t4@eg.com'], ['t4@eg.com'], 't3@eg.com',
            ['t1@eg.com', 't2@eg.com', 't3@eg.com', 't4@eg.com']
        ),
        (
            [('t1@eg.com', True), ('t2@eg.com', True)], ['t4@eg.com'], ['t5@eg.com'], 't3@eg.com',
            ['t1@eg.com', 't2@eg.com', 't3@eg.com', 't4@eg.com', 't5@eg.com']
        ),
        (
            [('t1@eg.com', True)], ['t4@eg.com', 't5@eg.com'], ['t5@eg.com', 't6@eg.com'], 't3@eg.com',
            ['t1@eg.com', 't3@eg.com', 't4@eg.com', 't5@eg.com', 't6@eg.com']
        )
    ]
)
def test_send_cancellation_emails_for_given_webinars(
    mocker, registered_users_with_response, cohosts, panelists, presenter, expected_email_addresses
):
    """
    Test if emails are sent to all the registered users, co-hosts, panelists and the presenter without any duplicates
    """
    mocked_task_send_mandrill_email = mocker.patch('openedx.adg.lms.webinars.helpers.task_send_mandrill_email')

    webinar = WebinarFactory(presenter__email=presenter)
    for email, invite_response in registered_users_with_response:
        WebinarRegistrationFactory(user__email=email, webinar=webinar, is_registered=invite_response)

    for cohost_email in cohosts:
        cohost = UserFactory(email=cohost_email)
        webinar.co_hosts.add(cohost)
        webinar.save()

    for panelist_email in panelists:
        panelist = UserFactory(email=panelist_email)
        webinar.panelists.add(panelist)
        webinar.save()

    send_cancellation_emails_for_given_webinars([webinar])

    expected_context = {
        'webinar_title': webinar.title,
        'webinar_description': webinar.description,
        'webinar_start_time': webinar.start_time.strftime("%B %d, %Y %I:%M %p %Z")
    }

    actual_template, actual_email_addresses, actual_context = mocked_task_send_mandrill_email.delay.call_args.args

    assert actual_template == MandrillClient.WEBINAR_CANCELLATION
    assert actual_context == expected_context
    assert sorted(actual_email_addresses) == sorted(expected_email_addresses)
