"""
Python tests for the Survey workflows
"""

from collections import OrderedDict

from django.core.urlresolvers import reverse

from survey.models import SurveyForm

from xmodule.modulestore.tests.factories import CourseFactory
from courseware.tests.helpers import LoginEnrollmentTestCase


class SurveyViewsTests(LoginEnrollmentTestCase):
    """
    All tests for the views.py file
    """

    STUDENT_INFO = [('view@test.com', 'foo')]

    def setUp(self):
        """
        Set up the test data used in the specific tests
        """
        super(SurveyViewsTests, self).setUp()

        self.test_survey_name = 'TestSurvey'
        self.test_form = '<input></input>'

        self.survey = SurveyForm.create(self.test_survey_name, self.test_form)

        self.student_answers = OrderedDict({
            u'field1': u'value1',
            u'field2': u'value2',
        })

        self.course = CourseFactory.create(
            course_survey_required=True,
            course_survey_name=self.test_survey_name
        )

        self.course_with_bogus_survey = CourseFactory.create(
            course_survey_required=True,
            course_survey_name="DoesNotExist"
        )

        self.course_without_survey = CourseFactory.create()

        # Create student accounts and activate them.
        for i in range(len(self.STUDENT_INFO)):
            email, password = self.STUDENT_INFO[i]
            username = 'u{0}'.format(i)
            self.create_account(username, email, password)
            self.activate_user(email)

        email, password = self.STUDENT_INFO[0]
        self.login(email, password)
        self.enroll(self.course, True)
        self.enroll(self.course_without_survey, True)
        self.enroll(self.course_with_bogus_survey, True)

        self.view_url = reverse('view_survey', args=[self.test_survey_name])
        self.postback_url = reverse('submit_answers', args=[self.test_survey_name])

    def test_visiting_course_without_survey(self):
        """
        Verifies that going to the courseware which does not have a survey does
        not redirect to a survey
        """
        resp = self.client.get(
            reverse(
                'courseware',
                kwargs={'course_id': unicode(self.course_without_survey.id)}
            )
        )
        self.assertEquals(resp.status_code, 200)

    def test_visiting_course_with_survey_redirects(self):
        """
        Verifies that going to the courseware with an unanswered survey, redirects to the survey
        """
        resp = self.client.get(
            reverse(
                'courseware',
                kwargs={'course_id': unicode(self.course.id)}
            )
        )
        self.assertRedirects(
            resp,
            reverse('course_survey', kwargs={'course_id': unicode(self.course.id)})
        )

    def test_visiting_course_with_existing_answers(self):
        """
        Verifies that going to the courseware with an answered survey, there is no redirect
        """
        resp = self.client.post(
            self.postback_url,
            self.student_answers
        )
        self.assertEquals(resp.status_code, 200)

        resp = self.client.get(
            reverse(
                'courseware',
                kwargs={'course_id': unicode(self.course.id)}
            )
        )
        self.assertEquals(resp.status_code, 200)

    def test_visiting_course_with_bogus_survey(self):
        """
        Verifies that going to the courseware with a required, but non-existing survey, does not redirect
        """

        resp = self.client.get(
            reverse(
                'courseware',
                kwargs={'course_id': unicode(self.course_with_bogus_survey.id)}
            )
        )
        self.assertEquals(resp.status_code, 200)

    def test_visiting_survey_with_bogus_survey_name(self):
        """
        Verifies that going to the courseware with a required, but non-existing survey, does not redirect
        """

        resp = self.client.get(
            reverse(
                'course_survey',
                kwargs={'course_id': unicode(self.course_with_bogus_survey.id)}
            )
        )
        self.assertRedirects(
            resp,
            reverse('courseware', kwargs={'course_id': self.course_with_bogus_survey.id.to_deprecated_string()})
        )

    def test_visiting_survey_with_no_course_survey(self):
        """
        Verifies that going to the courseware with a required, but non-existing survey, does not redirect
        """

        resp = self.client.get(
            reverse(
                'course_survey',
                kwargs={'course_id': unicode(self.course_without_survey.id)}
            )
        )
        self.assertRedirects(
            resp,
            reverse('courseware', kwargs={'course_id': unicode(self.course_without_survey.id)})
        )
