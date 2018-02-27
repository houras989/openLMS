"""
Model form for the surveys.
"""
import json
import logging
from datetime import datetime
from itertools import chain

import os
from django import forms
from django.utils.encoding import force_unicode
from django.utils.translation import ugettext_noop
from rest_framework.compat import MinValueValidator, MaxValueValidator

from lms.djangoapps.onboarding.email_utils import send_admin_activation_email
from lms.djangoapps.onboarding.helpers import COUNTRIES, get_country_iso, get_sorted_choices_from_dict, \
    get_actual_field_names, admin_not_assigned_or_me
from lms.djangoapps.onboarding.models import (
    UserExtendedProfile,
    Organization,
    OrganizationAdminHashKeys, EducationLevel, EnglishProficiency, RoleInsideOrg, OperationLevel,
    FocusArea, TotalEmployee, OrgSector, PartnerNetwork, OrganizationPartner, OrganizationMetric, Currency)

NO_OPTION_SELECT_ERROR = 'Please select an option for {}'
EMPTY_FIELD_ERROR = 'Please enter your {}'
log = logging.getLogger("edx.onboarding")


def get_onboarding_autosuggesion_data(file_name):
    """
    Receives a json file name and return data related to autocomplete fields in
    onboarding survey.
    """

    curr_dir = os.path.dirname(__file__)
    file_path = "{}/{}".format('data', file_name)
    json_file = open(os.path.join(curr_dir, file_path))
    data = json.load(json_file)
    return data


class BaseOnboardingModelForm(forms.ModelForm):
    def __init__(self, *args, **kwargs):
        kwargs.setdefault('label_suffix', kwargs.get('label_suffix', '').replace(":", ""))
        super(BaseOnboardingModelForm, self).__init__(*args, **kwargs)


class BaseOnboardingForm(forms.Form):
    def __init__(self, *args, **kwargs):
        kwargs.setdefault('label_suffix', kwargs.get('label_suffix', '').replace(":", ""))
        super(BaseOnboardingForm, self).__init__(*args, **kwargs)


class UserInfoModelForm(BaseOnboardingModelForm):
    """
    Model from to be used in the first step of survey.

    This will record some basic information about the user as modeled in
    'UserInfoSurvey' model
    """
    GENDER_CHOICES = (
        ('m', ugettext_noop('Male')),
        ('f', ugettext_noop('Female')),
        # Translators: 'Other' refers to the student's gender
        ('o', ugettext_noop("I'd rather not say")),
        ('nl', ugettext_noop('Not listed')),
    )

    NO_SELECT_CHOICE = [('', ugettext_noop('- Select -'))]

    LEVEL_OF_EDUCATION_CHOICES = NO_SELECT_CHOICE  + [(el.code, el.label)
                                                     for el in EducationLevel.objects.all()]
    ENGLISH_PROFICIENCY_CHOICES = NO_SELECT_CHOICE + [(ep.code, ep.label)
                                                     for ep in EnglishProficiency.objects.all()]
    ROLE_IN_ORG_CHOICES = NO_SELECT_CHOICE + [(r.code, r.label)
                                              for r in RoleInsideOrg.objects.all()]

    year_of_birth = forms.IntegerField(
        label="Year of Birth",
        label_suffix="*",
        validators=[
            MinValueValidator(1900, message=ugettext_noop('Ensure year of birth is greater than or equal to 1900')),
            MaxValueValidator(
                datetime.now().year, message=ugettext_noop('Ensure year of birth is less than or equal to {}'.format(
                    datetime.now().year
                ))
            )
        ],
        error_messages={
            'required': EMPTY_FIELD_ERROR.format(ugettext_noop("Year of birth")),
        }
    )
    gender = forms.ChoiceField(label=ugettext_noop('Gender'), required=False, label_suffix="*", choices=GENDER_CHOICES,
                               widget=forms.RadioSelect)

    language = forms.CharField(label=ugettext_noop('Native Language'), label_suffix="*", required=True,
                               error_messages={"required": ugettext_noop(EMPTY_FIELD_ERROR.format('Language'))})
    country = forms.CharField(label="Country of Residence", label_suffix="*",
                              error_messages={"required": ugettext_noop(EMPTY_FIELD_ERROR.format("Country of Residence"))
    })
    city = forms.CharField(label=ugettext_noop('City of Residence'), required=False)
    is_emp_location_different = forms.BooleanField(label=ugettext_noop('Check here if your country and/or city of '
                                                                       'employment is different from your country '
                                                                       'and/or city of residence.'),
                                                   required=False)
    level_of_education = forms.ChoiceField(label=ugettext_noop('Level of Education'), label_suffix="*",
                                           choices=LEVEL_OF_EDUCATION_CHOICES,
                                           error_messages={
                                                'required': ugettext_noop(NO_OPTION_SELECT_ERROR.format(
                                                    'Level of Education')),
                                           },
                                           required=True)
    english_proficiency = forms.ChoiceField(label=ugettext_noop('English Language Proficiency'), label_suffix="*",
                                            choices=ENGLISH_PROFICIENCY_CHOICES,
                                            error_messages={
                                                 'required': ugettext_noop(NO_OPTION_SELECT_ERROR.format(
                                                     'English Language Proficiency')),
                                            })
    role_in_org = forms.ChoiceField(label=ugettext_noop('Role in the Organization'),
                                    label_suffix="*",
                                    choices=ROLE_IN_ORG_CHOICES,
                                    error_messages={
                                         'required': ugettext_noop(NO_OPTION_SELECT_ERROR.format(
                                             'Role in the Organization')),
                                    })

    def __init__(self,  *args, **kwargs):
        super(UserInfoModelForm, self).__init__( *args, **kwargs)

        self.fields['country_of_employment'].required = False
        self.fields['city_of_employment'].required = False

        focus_area_choices = ((field_name, label) for field_name, label in
                                UserExtendedProfile.FUNCTIONS_LABELS.items())

        focus_area_choices = sorted(focus_area_choices, key=lambda focus_area_choices: focus_area_choices[0])

        self.fields['function_areas'] = forms.ChoiceField(choices=focus_area_choices,
            label=ugettext_noop('Department or Function (Check all that apply.)'),
            widget=forms.CheckboxSelectMultiple)

    def clean(self):
        if self.errors.get('function_areas'):
            del self.errors['function_areas']

    def clean_gender(self):

        not_listed_gender = self.data.get('not_listed_gender', None)
        gender = self.cleaned_data['gender']

        if not gender:
            raise forms.ValidationError('Please select Gender.')

        if gender == 'nl' and not not_listed_gender:
            raise forms.ValidationError('Please specify Gender.')

        return gender

    def clean_country(self):
        all_countries = COUNTRIES.values()
        country = self.cleaned_data['country']

        if country in all_countries:
            return country

        raise forms.ValidationError(ugettext_noop('Please select country of residence.'))

    def clean_language(self):
        all_languages = get_onboarding_autosuggesion_data('world_languages.json')
        submitted_language = self.cleaned_data['language']

        if submitted_language in all_languages:
            return submitted_language

        raise forms.ValidationError(ugettext_noop('Please select language.'))

    class Meta:
        """
        The meta class used to customize the default behaviour of form fields
        """
        model = UserExtendedProfile
        fields = [
            'year_of_birth', 'gender', 'not_listed_gender', 'not_listed_gender', 'level_of_education', 'language',
            'english_proficiency', 'country', 'city', 'is_emp_location_different', 'country_of_employment',
            'city_of_employment', 'role_in_org', 'start_month_year', 'hours_per_week'
        ]

        labels = {
            'is_emp_location_different': ugettext_noop('Check here if your country and/or city of employment is different'
                                         ' from your country and/or city of residence.'),
            'start_month_year': ugettext_noop('Start Month and Year*'),
            'country_of_employment': ugettext_noop('Country of Employment'),
            'city_of_employment': ugettext_noop('City of Employment'),
            'role_in_org': ugettext_noop('Role in Organization*'),
        }
        widgets = {
            'year_of_birth': forms.TextInput,
            'country': forms.TextInput,
            'not_listed_gender': forms.TextInput(attrs={'placeholder': ugettext_noop('Identify your gender here')}),
            'city': forms.TextInput,
            'language': forms.TextInput,
            'country_of_employment': forms.TextInput,
            'city_of_employment': forms.TextInput,
            'start_month_year': forms.TextInput(attrs={'placeholder': 'mm/yy'}),
            'hours_per_week': forms.NumberInput(attrs={'max': 168})
        }

        error_messages = {
            "hours_per_week": {
                'required': EMPTY_FIELD_ERROR.format(ugettext_noop('Typical Number of Hours Worked per Week'))
            },
            'start_month_year': {
                'required': EMPTY_FIELD_ERROR.format(ugettext_noop('Start Month and Year')),
            }
        }

    def save(self, request, commit=True):
        user_info_survey = super(UserInfoModelForm, self).save()

        userprofile = user_info_survey.user.profile
        userprofile.year_of_birth = self.cleaned_data['year_of_birth']
        userprofile.language = self.cleaned_data['language']

        userprofile.country = get_country_iso(request.POST['country'])
        userprofile.city = self.cleaned_data['city']
        userprofile.level_of_education = self.cleaned_data['level_of_education']
        if self.cleaned_data['gender']:
            userprofile.gender = self.cleaned_data['gender']
        userprofile.save()

        if request.POST.get('country_of_employment'):
            user_info_survey.country_of_employment = get_country_iso(request.POST.get('country_of_employment'))
        user_info_survey.city_of_employment = self.cleaned_data['city_of_employment']

        selected_function_areas = get_actual_field_names(request.POST.getlist('function_areas'))
        user_info_survey.user.extended_profile.save_user_function_areas(selected_function_areas)
        if commit:
            user_info_survey.save()

        return user_info_survey


class RadioSelectNotNull(forms.RadioSelect):
    """
    A widget which removes the default '-----' option from RadioSelect
    """
    def get_renderer(self, name, value, attrs=None, choices=()):
        """
        Returns an instance of the renderer.
        """
        if value is None: value = ''
        # Normalize to string.
        str_value = force_unicode(value)
        final_attrs = self.build_attrs(attrs)
        choices = list(chain(self.choices, choices))
        if choices[0][0] == '':
            choices.pop(0)
        return self.renderer(name, str_value, final_attrs, choices)


class InterestsForm(BaseOnboardingForm):
    """
    Model from to be used in the second step of survey.

    This will record user's interests information as modeled in
    'UserExtendedProfile' model.
    """

    def __init__(self,  *args, **kwargs):
        super(InterestsForm, self).__init__( *args, **kwargs)

        interest_choices = get_sorted_choices_from_dict(UserExtendedProfile.INTERESTS_LABELS)
        interest_choices = sorted(interest_choices, key=lambda interest_choices: interest_choices[0])
        self.fields['interests'] = forms.ChoiceField(
            label=ugettext_noop('Which of these areas of organizational effectiveness are you most interested '
                                'to learn more about? (Check all that apply.)'),
            choices=interest_choices, widget=forms.CheckboxSelectMultiple,
            required=False)

        interested_learners_choices = get_sorted_choices_from_dict(UserExtendedProfile.INTERESTED_LEARNERS_LABELS)
        interested_learners_choices = sorted(interested_learners_choices,
                                             key=lambda interested_learners_choices: interested_learners_choices[0])
        self.fields['interested_learners'] = forms.ChoiceField(
            label=ugettext_noop('Which types of other Philanthropy University learners are interesting to you? '
                                '(Check all that apply.)'),
            choices=interested_learners_choices, widget=forms.CheckboxSelectMultiple,
            required=False)

        personal_goal_choices = get_sorted_choices_from_dict(UserExtendedProfile.GOALS_LABELS)
        personal_goal_choices = sorted(personal_goal_choices,
                                       key=lambda personal_goal_choices: personal_goal_choices[0])
        self.fields['personal_goals'] = forms.ChoiceField(
            label=ugettext_noop('What is your most important personal goal in joining Philanthropy University? '
                                '(Check all that apply.)'),
            choices=personal_goal_choices, widget=forms.CheckboxSelectMultiple,
            required=False)

    def _clean_fields(self):
        """
        Override to prevent 'valid choice options' validations
        """
        return True

    def save(self, request, user_extended_profile):
        """
        save form selected choices without any validation
        """
        selected_interests = get_actual_field_names(request.POST.getlist('interests'))
        selected_interested_learners = get_actual_field_names(request.POST.getlist('interested_learners'))
        selected_personal_goals = get_actual_field_names(request.POST.getlist('personal_goals'))

        user_extended_profile.save_user_interests(selected_interests)
        user_extended_profile.save_user_interested_learners(selected_interested_learners)
        user_extended_profile.save_user_personal_goals(selected_personal_goals)
        user_extended_profile.is_interests_data_submitted = True
        user_extended_profile.save()


class OrganizationInfoForm(BaseOnboardingModelForm):
    """
    Model from to be used in the third step of survey.

    This will record information about user's organization as modeled in
    'OrganizationSurvey' model.
    """

    NO_SELECT_CHOICE = [('', '- Select -')]

    ORG_TYPE_CHOICES = NO_SELECT_CHOICE + [(os.code, os.label) for os in OrgSector.objects.all()]
    OPERATION_LEVEL_CHOICES = NO_SELECT_CHOICE + [(ol.code, ol.label)
                                                  for ol in OperationLevel.objects.all()]
    FOCUS_AREA_CHOICES = NO_SELECT_CHOICE + [(fa.code, fa.label) for fa in FocusArea.objects.all()]
    TOTAL_EMPLOYEES_CHOICES = NO_SELECT_CHOICE + [(ep.code, ep.label)
                                                  for ep in TotalEmployee.objects.all()]
    PARTNER_NETWORK_CHOICES = [(pn.code, pn.label) for pn in PartnerNetwork.objects.all()]

    is_org_url_exist = forms.ChoiceField(label=ugettext_noop('Does your organization have a website?'),
                                         choices=((1, ugettext_noop('Yes')), (0, ugettext_noop('No'))),
                                         label_suffix="*",
                                         widget=forms.RadioSelect,
                                         initial=1,
                                         help_text=ugettext_noop("If your organization does not have its own website, "
                                                                 "but it does have a page on another platform like "
                                                                 "Facebook or WordPress, please answer Yes here and "
                                                                 "give the address for this page."),
                                         error_messages={
                                            'required': ugettext_noop('Please select an option for "Does your organization have a'
                                                        ' webpage?"'),
                                         })

    org_type = forms.ChoiceField(label=ugettext_noop('Organization Type'), label_suffix="*",
                                 choices=ORG_TYPE_CHOICES,
                                 error_messages={
                                     'required': ugettext_noop(NO_OPTION_SELECT_ERROR.format(
                                         'Organization Type')),
                                 })

    level_of_operation = forms.ChoiceField(label=ugettext_noop('Level of Operation'), label_suffix="*",
                                           choices=OPERATION_LEVEL_CHOICES,
                                           error_messages={
                                               'required': ugettext_noop(NO_OPTION_SELECT_ERROR.format(
                                                   'Level of Operation')),
                                           })

    focus_area = forms.ChoiceField(label=ugettext_noop('Primary Focus Area'), label_suffix="*",
                                   choices=FOCUS_AREA_CHOICES,
                                   error_messages={
                                       'required': ugettext_noop(NO_OPTION_SELECT_ERROR.format(
                                           'Primary Focus Areas')),
                                   })

    total_employees = forms.ChoiceField(label=ugettext_noop('Total Employees'), label_suffix="*",
                                        help_text="An employee is a member of your staff who is paid for their work. "
                                                  "A staff member working full-time counts as 1 employee; a staff "
                                                  "member working half-time counts as 0.5 of an employee. Please "
                                                  "include yourself in your organization's employee count.",
                                        choices=TOTAL_EMPLOYEES_CHOICES,
                                        error_messages={
                                            'required': ugettext_noop(NO_OPTION_SELECT_ERROR.format('Total Employees')),
                                        })

    partner_networks = forms.ChoiceField(label=ugettext_noop("Is your organization currently working with any of "
                                                             "Philanthropy University's partners? "
                                                             "(Check all that apply.)"),
                                         help_text=ugettext_noop("Philanthropy University works in partnership with a "
                                                                 "number of organizations to improve the "
                                                                 "effectiveness of local organizations they fund and/or"
                                                                 " partner with to deliver programs. If you were asked "
                                                                 "to join Philanthropy University by one of your "
                                                                 "partners or funders and that organization appears in "
                                                                 "this list, please select it."),
                                         choices=PARTNER_NETWORK_CHOICES,
                                         widget=forms.CheckboxSelectMultiple,
                                         required=False,
                                         error_messages={
                                             'required': ugettext_noop(NO_OPTION_SELECT_ERROR.format("Partner's")),
                                         })

    def __init__(self,  *args, **kwargs):
        super(OrganizationInfoForm, self).__init__( *args, **kwargs)
        self.fields['city'].required = False
        self.fields['founding_year'].required = True

    class Meta:
        """
        The meta class used to customize the default behaviour of form fields
        """
        model = Organization
        fields = ['country', 'city', 'is_org_url_exist', 'url', 'founding_year', 'focus_area',
                  'org_type', 'level_of_operation', 'total_employees', 'alternate_admin_email', 'partner_networks']

        widgets = {
            'country': forms.TextInput,
            'city': forms.TextInput,
            'url': forms.TextInput,
            'founding_year': forms.NumberInput,
            'alternate_admin_email': forms.TextInput,
            'registration_number': forms.TextInput
        }

        labels = {
            'country': ugettext_noop('Country of Organization Headquarters*'),
            'city': ugettext_noop('City of Organization Headquarters'),
            'founding_year': ugettext_noop('Founding Year*'),
            'is_org_url_exist': ugettext_noop('Does your organization have a webpage?'),
            'url': ugettext_noop('Website Address*'),
            'alternate_admin_email': ugettext_noop('Please provide the email address for an alternative Administrator '
                                                   'contact at your organization if we are unable to reach you.'),
        }

        required_error = 'Please select an option for {}'

        error_messages = {
            'founding_year': {
                'required': ugettext_noop(EMPTY_FIELD_ERROR.format('Founding Year')),
            },
            'country': {
                'required': ugettext_noop(EMPTY_FIELD_ERROR.format('Country of Organization Headquarters')),
            }
        }

        help_texts = {
            "founding_year": ugettext_noop("Founding year is the year that your organization was started. This may be "
                                           "before your organization was legally registered."),
        }

    def clean_country(self):
        all_countries = COUNTRIES.values()
        country = self.cleaned_data['country']

        if country in all_countries:
            return country

        raise forms.ValidationError(ugettext_noop('Please select country of Organization Headquarters.'))

    def clean_url(self):
        is_org_url_exist = int(self.data.get('is_org_url_exist')) if self.data.get('is_org_url_exist') else None
        organization_website = self.cleaned_data.get('url', '').replace('http://', 'https://', 1)

        if is_org_url_exist and not organization_website:
            raise forms.ValidationError(EMPTY_FIELD_ERROR.format(ugettext_noop('Organization Website')))

        elif not is_org_url_exist:
            organization_website = ''

        return organization_website

    def clean(self):
        """
        Clean the form after submission and ensure that year is 4 digit positive number.
        """
        cleaned_data = super(OrganizationInfoForm, self).clean()

        if self.errors.get('partner_networks'):
            del self.errors['partner_networks']

        year = cleaned_data.get('founding_year', '')

        if year:
            if len("{}".format(year)) < 4 or year < 0 or len("{}".format(year)) > 4:
                self.add_error(
                    'founding_year',
                    ugettext_noop('You entered an invalid year format. Please enter a valid year with 4 digits.')
                )

    def save(self, request, commit=True):
        organization = super(OrganizationInfoForm, self).save(commit=False)
        organization.country = get_country_iso(self.cleaned_data['country'])

        if commit:
            organization.save()

        partners = request.POST.getlist('partner_networks')

        if partners:
            OrganizationPartner.update_organization_partners(organization, partners)


class RegModelForm(BaseOnboardingModelForm):
    """
    Model form for extra fields in registration model
    """

    IS_POC_CHOICES = (
        (1, ugettext_noop('Yes')),
        (0, ugettext_noop('No'))
    )

    first_name = forms.CharField(
        label=ugettext_noop('First Name'),
        label_suffix="*",
        widget=forms.TextInput(
            attrs={'placeholder': ugettext_noop('First Name')}
        )
    )

    last_name = forms.CharField(
        label=ugettext_noop('Last Name'),
        label_suffix="*",
        widget=forms.TextInput(
            attrs={'placeholder': ugettext_noop('Last Name')}
        )
    )

    organization_name = forms.CharField(
        max_length=255,
        label=ugettext_noop('Organization Name'),
        label_suffix="*",
        help_text=ugettext_noop("You can choose an organization from the auto-suggestion list or add a new one by "
                                "entering the name and clicking the OK button."),
        required=False,
        widget=forms.TextInput(
            attrs={'placeholder': ugettext_noop('Organization Name')}
        ),
        initial=ugettext_noop('Organization Name')
    )

    confirm_password = forms.CharField(
        label=ugettext_noop('Confirm Password'),
        widget=forms.PasswordInput
    )

    is_currently_employed = forms.BooleanField(
        initial=False,
        required=False,
        label=ugettext_noop('Check here if you are currently unemployed or otherwise not affiliated with an '
                            'organization.')
        )

    is_poc = forms.ChoiceField(label=ugettext_noop('Will you be the Administrator of your organization on our '
                                                   'website?'),
                               help_text=ugettext_noop("Your organization's PhilU Administrator is responsible for "
                                                       "maintaining your organization's profile, inviting learners "
                                                       "from your organization to the PhilU platform, completing "
                                                       "the Organizational Effectiveness Framework assessment and "
                                                       "updating it over time. Your Administrator should be the most "
                                                       "senior person in your organization responsible for "
                                                       "organizational capacity building and learning. In a small "
                                                       "organization with few employees, the Organization "
                                                       "Administrator might be the Executive Director or "
                                                       "Chief Executive. In a larger organization, the "
                                                       "Organization Administrator might be the director or "
                                                       "manager responsible for staff learning and development "
                                                       "and organizational capacity assessment and development "
                                                       "planning."),
                               choices=IS_POC_CHOICES,
                               widget=forms.RadioSelect)

    org_admin_email = forms.CharField(
        required=False,
        widget=forms.EmailInput(attrs={'placeholder': 'Organization Admin email'}))

    def __init__(self, *args, **kwargs):
        super(RegModelForm, self).__init__(*args, **kwargs)

        self.fields['first_name'].error_messages = {
            'required': ugettext_noop('Please enter your First Name.'),
        }

        self.fields['last_name'].error_messages = {
            'required': ugettext_noop('Please enter your Last Name.'),
        }

        self.fields['organization_name'].error_messages = {
            'required': ugettext_noop('Please select your Organization.'),
        }

        self.fields['confirm_password'].error_messages = {
            'required': ugettext_noop('Please enter your Confirm Password.'),
        }

    class Meta:
        model = UserExtendedProfile

        fields = (
            'confirm_password', 'first_name', 'last_name',
            'organization_name', 'is_currently_employed', 'is_poc', 'org_admin_email',
        )

        labels = {
            'username': 'Public Username*',

        }

        widgets = {
            'first_name': forms.TextInput(attrs={'placeholder': 'First Name'}),
            'last_name': forms.TextInput(attrs={'placeholder': 'Last Name'})
        }

        serialization_options = {
            'confirm_password': {'field_type': 'password'},
            'org_admin_email': {'field_type': 'email'}
        }

    def clean_organization_name(self):
        organization_name = self.cleaned_data['organization_name']

        if not self.data.get('is_currently_employed') and not organization_name:
            raise forms.ValidationError(ugettext_noop('Please enter organization name'))

        return organization_name

    def clean_org_admin_email(self):
        org_admin_email = self.cleaned_data['org_admin_email']

        already_an_admin = Organization.objects.filter(admin__email=org_admin_email).first()
        if already_an_admin:
            raise forms.ValidationError(ugettext_noop('%s is already admin of organization "%s"'
                                                      % (org_admin_email, already_an_admin.label)))

        already_suggested_as_admin = OrganizationAdminHashKeys.objects.filter(
            suggested_admin_email=org_admin_email, is_hash_consumed=False).first()
        if already_suggested_as_admin:
            raise forms.ValidationError(ugettext_noop('%s is already suggested as admin of "%s" organization'
                                                      % (org_admin_email,
                                                         already_suggested_as_admin.organization.label)))

        return org_admin_email

    def save(self, user=None, commit=True):
        organization_name = self.cleaned_data.get('organization_name', '').strip()
        is_poc = self.cleaned_data['is_poc']
        org_admin_email = self.cleaned_data['org_admin_email']
        first_name = self.cleaned_data['first_name']
        last_name = self.cleaned_data['last_name']
        is_currently_unemployed = self.cleaned_data['is_currently_employed']

        extended_profile = UserExtendedProfile.objects.create(user=user)

        if not is_currently_unemployed and organization_name:
            organization_to_assign, is_created = Organization.objects.get_or_create(label=organization_name)
            extended_profile.organization = organization_to_assign

            if user and is_poc == '1':
                organization_to_assign.unclaimed_org_admin_email = None
                organization_to_assign.admin = user

            if not is_poc == '1' and org_admin_email:
                try:

                    hash_key = OrganizationAdminHashKeys.assign_hash(organization_to_assign, user, org_admin_email)
                    org_id = extended_profile.organization_id
                    org_name = extended_profile.organization.label
                    organization_to_assign.unclaimed_org_admin_email = org_admin_email
                    claimed_by_name = "{first_name} {last_name}".format(first_name=first_name, last_name=last_name)
                    claimed_by_email = self.data["email"]
                    send_admin_activation_email(first_name, org_id, org_name, claimed_by_name,
                                                claimed_by_email, org_admin_email, hash_key)

                except Exception as ex:
                    log.info(ex.args)
                    pass

        user.first_name = first_name
        user.last_name = last_name

        if commit:
            extended_profile.save()

        return extended_profile


class UpdateRegModelForm(RegModelForm):
    """
    Model form to update the registration extra fields
    """
    def __init__(self, *args, **kwargs):
        super(UpdateRegModelForm, self).__init__(*args, **kwargs)
        self.fields.pop('confirm_password')

    def save(self, user=None, commit=True):
        organization_name = self.cleaned_data.get('organization_name', '').strip()
        is_poc = self.cleaned_data['is_poc']
        first_name = self.cleaned_data['first_name']
        last_name = self.cleaned_data['last_name']
        is_currently_unemployed = self.cleaned_data['is_currently_employed']

        extended_profile = UserExtendedProfile.objects.get(user=user)

        if not is_currently_unemployed and organization_name:
            organization_to_assign, is_created = Organization.objects.get_or_create(label=organization_name)
            prev_org = extended_profile.organization
            extended_profile.organization = organization_to_assign

            # Reset organizations under my administrations if i updated my organization + ask for org details
            if not prev_org == organization_to_assign:
                Organization.objects.filter(admin=user).update(admin=None)
                extended_profile.is_organization_metrics_submitted = False

            # if user check YES option on account settings page => set user as admin of selected/created organization
            if user and is_poc == '1' and admin_not_assigned_or_me(user, organization_to_assign):
                organization_to_assign.unclaimed_org_admin_email = None
                organization_to_assign.admin = user

            # if user check NO option on account settings page => clear my admin status if i was admin
            if not is_poc == '1':
                if organization_to_assign.admin == user:
                    organization_to_assign.admin = None

        elif is_currently_unemployed:
            if extended_profile.organization and extended_profile.organization.admin == user:
                extended_profile.organization.admin = None
                extended_profile.organization.save()

            extended_profile.organization = None
            extended_profile.is_organization_metrics_submitted = False

        user.first_name = first_name
        user.last_name = last_name

        if commit:
            user.save()
            extended_profile.save()

            if extended_profile.organization:
                extended_profile.organization.save()

        return extended_profile


class OrganizationMetricModelForm(BaseOnboardingModelForm):
    can_provide_info = forms.ChoiceField(label=ugettext_noop('Are you able to provide information requested bellow?'),
                                         choices=((1, ugettext_noop('Yes')), (0, ugettext_noop('No'))),
                                         label_suffix="*",
                                         widget=forms.RadioSelect,
                                         initial=1,
                                         error_messages={
                                             'required': ugettext_noop('Please select an option for Are you able to '
                                                                       'provide information'),
                                         })
    effective_date = forms.DateField(input_formats=['%m/%d/%Y'],
                                     required=False,
                                     label=ugettext_noop('End date of last Fiscal Year'),
                                     help_text=ugettext_noop("The fiscal year is the period that an organization uses "
                                                             "for accounting  purposes and preparing financial "
                                                             "statements. A fiscal year may or may not be the same"
                                                             " as a calendar year. If the information you are "
                                                             "giving below is for the last 12 months, please enter "
                                                             "today's date."),
                                     label_suffix='*')
    registration_number = forms.CharField(max_length=30,
                                          required=False,
                                          label=ugettext_noop("Organization's Registration or Tax Identification Number"),
                                          help_text=ugettext_noop("A registration or tax identification number is the unique number your"
                                                                  " government uses to identify your organization. Please note that you "
                                                                  "should only give information that you are allowed to share and that "
                                                                  "is available to the public. You should not give nonpublic or "
                                                                  "confidential information."))

    def __init__(self,  *args, **kwargs):
        super(OrganizationMetricModelForm, self).__init__(*args, **kwargs)
        self.fields['actual_data'].empty_label = None
        self.fields['actual_data'].required = False

    class Meta:
        model = OrganizationMetric

        fields = [
            'can_provide_info', 'actual_data', 'effective_date', 'total_clients', 'total_employees', 'local_currency',
            'total_revenue', 'total_donations', 'total_expenses', 'total_program_expenses',
        ]

        widgets = {
            'can_provide_info': forms.RadioSelect,
            'actual_data': RadioSelectNotNull,
            'effective_date': forms.TextInput,
            'total_clients': forms.NumberInput,
            'total_employees': forms.NumberInput,
            'local_currency': forms.TextInput,
            'total_revenue': forms.NumberInput,
            'total_donations': forms.NumberInput,
            'total_expenses': forms.NumberInput,
            'total_program_expenses': forms.NumberInput,
        }

        labels = {
            'actual_data': ugettext_noop('Is the information you will provide on this page estimated or actual?*'),
            'total_clients': ugettext_noop('Total Annual Clients or Direct Beneficiaries for Last Fiscal Year'),
            'total_employees': ugettext_noop('Total Employees at the End of Last Fiscal Year'),
            'local_currency': ugettext_noop('Local Currency Code*'),
            'total_revenue': ugettext_noop('Total Annual Revenue for Last Fiscal Year* (Local Currency)'),
            'total_donations': ugettext_noop('Total Donations and Grants Received Last Fiscal Year (Local Currency)'),
            'total_expenses': ugettext_noop('Total Annual Expenses for Last Fiscal Year (Local Currency)'),
            'total_program_expenses': ugettext_noop('Total Annual Program Expenses for Last Fiscal Year '
                                                    '(Local Currency)'),
        }

        help_texts = {
            "actual_data": ugettext_noop("If you don't have access to information from official documents, please give "
                                         "your best guesses based on your knowledge of your organization. Please note "
                                         "that you should only give information that you are allowed to share and that "
                                         "is available to the public. You should not give nonpublic or confidential "
                                         "information."),
            "total_clients" : ugettext_noop("A client or direct beneficiary is any person benefiting directly from your "
                                           "organization's activities through face-to-face contact with program staff, "
                                           "often in a one-on-one or small-group setting. Please do not include "
                                           "indirect beneficiaries or people your organization reaches on a lighter "
                                           "scale, such as through one-time events. If your organization does not "
                                           "serve people directly because, for example, you work with animals, the "
                                           "environment, or in arts and culture, please provide a reasonable estimate "
                                           "for the number of people or animals that benefit from your services."),
            "total_employees": ugettext_noop("An employee is a member of your staff who is paid for their work. A staff"
                                             " member working full-time counts as 1 employee; a staff member working "
                                             "half-time counts as 0.5 of an employee. Please include yourself in your "
                                             "organization's employee count. We asked a similar question on the last "
                                             "page, but here we are asking for the number of employees at the end of "
                                             "your last fiscal year instead of your current number."),
            "total_revenue": ugettext_noop("Revenue is the total amount of money your organization receives, regardless"
                                           "of the source of that funding. Sources of revenue may include fees for "
                                           "services and goods, government contracts, donations, grants, or investment "
                                           "income."),
            "total_donations": ugettext_noop("Donations and grants are two different sources of revenue. A donation is"
                                             " funding given to your organization with nothing or very little "
                                             "expected in return. An unrestricted cash gift from a private individual"
                                             " is a donation. A grant is funding given to your organization for a"
                                             " particular purpose with some obligations, such as reporting.  Revenue"
                                             " from government sources should also be included in this line."),
            "total_expenses": ugettext_noop("An expense is money your organization spends in order to deliver its "
                                            "programs, operate the business, and generate revenue. Expenses may "
                                            "include. wages and salaries, rent, insurance, travel, or supplies."),
            "total_program_expenses": ugettext_noop("A program expense is money your organization spends exclusively "
                                                    "in order to deliver its programs and should not include "
                                                    "administrative or fundraising expenses. These program expenses"
                                                    " should also be included in your total annual expenses for last "
                                                    "fiscal year above."),
        }

    def clean_actual_data(self):
        can_provide_info = int(self.data['can_provide_info']) if self.data.get('can_provide_info') else False
        info_accuracy = self.cleaned_data['actual_data']

        if can_provide_info and info_accuracy not in [True, False]:
            raise forms.ValidationError(ugettext_noop("Please select an option for Estimated or Actual Information"))

        return info_accuracy

    def clean_effective_date(self):
        can_provide_info = int(self.data.get('can_provide_info')) if self.data.get('can_provide_info') else False
        last_fiscal_year_end_date = self.cleaned_data['effective_date']

        if can_provide_info and not last_fiscal_year_end_date:
            raise forms.ValidationError(ugettext_noop(EMPTY_FIELD_ERROR.format("End date for Last Fiscal Year")))

        if last_fiscal_year_end_date > datetime.now().date():
            raise forms.ValidationError(ugettext_noop("Invalid Date"))

        return last_fiscal_year_end_date

    def clean_total_clients(self):
        can_provide_info = int(self.data.get('can_provide_info')) if self.data.get('can_provide_info') else False
        total_clients = self.cleaned_data['total_clients']

        if can_provide_info and not total_clients:
            raise forms.ValidationError(ugettext_noop(EMPTY_FIELD_ERROR.format("Total Client")))

        return total_clients

    def clean_total_employees(self):
        can_provide_info = int(self.data.get('can_provide_info')) if self.data.get('can_provide_info') else False
        total_employees = self.cleaned_data['total_employees']

        if can_provide_info and not total_employees:
            raise forms.ValidationError(ugettext_noop(EMPTY_FIELD_ERROR.format("Total Employees")))

        return total_employees

    def clean_local_currency(self):
        can_provide_info = int(self.data['can_provide_info']) if self.data.get('can_provide_info') else False
        all_currency_codes = Currency.objects.values_list('alphabetic_code', flat=True)
        currency_input = self.cleaned_data['local_currency']

        if can_provide_info and not currency_input in all_currency_codes:
            raise forms.ValidationError(ugettext_noop('Please select currency code.'))

        return currency_input

    def clean_total_revenue(self):
        can_provide_info = int(self.data.get('can_provide_info')) if self.data.get('can_provide_info') else False
        total_revenue = self.cleaned_data['total_revenue']

        if can_provide_info and not total_revenue:
            raise forms.ValidationError(ugettext_noop(EMPTY_FIELD_ERROR.format("Total Revenue")))

        return total_revenue

    def clean_total_donations(self):
        can_provide_info = int(self.data.get('can_provide_info')) if self.data.get('can_provide_info') else False
        total_donations = self.cleaned_data['total_donations']

        if can_provide_info and not total_donations:
            raise forms.ValidationError(ugettext_noop(EMPTY_FIELD_ERROR.format("Total Donations")))

        return total_donations

    def clean_total_expenses(self):
        can_provide_info = int(self.data.get('can_provide_info')) if self.data.get('can_provide_info') else False
        total_expenses = self.cleaned_data['total_expenses']

        if can_provide_info and not total_expenses:
            raise forms.ValidationError(ugettext_noop(EMPTY_FIELD_ERROR.format("Total Expenses")))

        return total_expenses

    def clean_total_program_expenses(self):
        can_provide_info = int(self.data.get('can_provide_info')) if self.data.get('can_provide_info') else False
        total_program_expenses = self.cleaned_data['total_program_expenses']

        if can_provide_info and not total_program_expenses:
            raise forms.ValidationError(ugettext_noop(EMPTY_FIELD_ERROR.format("Total Program Expense")))

        return total_program_expenses

    def save(self, request):
        user_extended_profile = request.user.extended_profile
        can_provide_info = int(self.data['can_provide_info'])

        if can_provide_info:
            org_detail = super(OrganizationMetricModelForm, self).save(commit=False)
            org_detail.user = request.user
            org_detail.org = user_extended_profile.organization
            org_detail.local_currency = Currency.objects.filter(
                alphabetic_code=self.cleaned_data['local_currency']).first().alphabetic_code

            org_detail.save()

        if self.data['registration_number']:
            user_extended_profile.organization.registration_number = self.data['registration_number']
            user_extended_profile.organization.save()

        user_extended_profile.is_organization_metrics_submitted = True
        user_extended_profile.save()


class OrganizationMetricModelUpdateForm(OrganizationMetricModelForm):
    effective_date = forms.DateField(input_formats=['%m/%d/%Y'],
                                     required=False,
                                     help_text=ugettext_noop("The fiscal year is the period that an organization uses "
                                                             "for accounting  purposes and preparing financial "
                                                             "statements. A fiscal year may or may not be the same"
                                                             " as a calendar year. If the information you are "
                                                             "giving below is for the last 12 months, please enter "
                                                             "today's date."),
                                     label=ugettext_noop('End Date of Last Fiscal Year'),
                                     label_suffix='*')

    registration_number = forms.CharField(max_length=30,
                                          required=False,
                                          label=ugettext_noop(
                                              "Organization's Registration or Tax Identification Number"),
                                          help_text=ugettext_noop(
                                              "A registration or tax identification number is the unique number your"
                                              " government uses to identify your organization. Please note that you "
                                              "should only give information that you are allowed to share and that "
                                              "is available to the public. You should not give nonpublic or "
                                              "confidential information."))

    def __init__(self,  *args, **kwargs):
        super(OrganizationMetricModelForm, self).__init__(*args, **kwargs)
        self.fields['actual_data'].empty_label = None
        self.fields['actual_data'].required = False
        self.fields['can_provide_info'].required = False

    class Meta:
        model = OrganizationMetric

        fields = [
            'actual_data', 'effective_date', 'total_clients', 'total_employees', 'local_currency',
            'total_revenue', 'total_donations', 'total_expenses', 'total_program_expenses'
        ]

        widgets = {
            'actual_data': RadioSelectNotNull,
            'effective_date': forms.TextInput,
            'total_clients': forms.NumberInput,
            'total_employees': forms.NumberInput,
            'local_currency': forms.TextInput,
            'total_revenue': forms.NumberInput,
            'total_donations': forms.NumberInput,
            'total_expenses': forms.NumberInput,
            'total_program_expenses': forms.NumberInput,
        }

        labels = {
            'actual_data': ugettext_noop('Is the information you will provide on this page estimated or actual?'),
            'total_clients': ugettext_noop('Total Annual Clients or Direct Beneficiaries for Last Fiscal Year'),
            'total_employees': ugettext_noop('Total Employees at the End of Last Fiscal Year'),
            'local_currency': ugettext_noop('Local Currency Code*'),
            'total_revenue': ugettext_noop('Total Annual Revenue for Last Fiscal Year* (Local Currency)'),
            'total_donations': ugettext_noop('Total Donations and Grants Received Last Fiscal Year (Local Currency)'),
            'total_expenses': ugettext_noop('Total Annual Expenses for Last Fiscal Year (Local Currency)'),
            'total_program_expenses': ugettext_noop('Total Annual Program Expenses for Last Fiscal Year '
                                                    '(Local Currency)'),
        }

        help_texts = {
            "actual_data": ugettext_noop("If you don't have access to information from official documents, please give "
                                         "your best guesses based on your knowledge of your organization. Please note "
                                         "that you should only give information that you are allowed to share and that "
                                         "is available to the public. You should not give nonpublic or confidential "
                                         "information."),
            "total_clients": ugettext_noop("A client or direct beneficiary is any person benefiting directly from your "
                                           "organization's activities through face-to-face contact with program staff, "
                                           "often in a one-on-one or small-group setting. Please do not include "
                                           "indirect beneficiaries or people your organization reaches on a lighter "
                                           "scale, such as through one-time events. If your organization does not "
                                           "serve people directly because, for example, you work with animals, the "
                                           "environment, or in arts and culture, please provide a reasonable estimate "
                                           "for the number of people or animals that benefit from your services."),
            "total_employees": ugettext_noop("An employee is a member of your staff who is paid for their work. A staff"
                                             " member working full-time counts as 1 employee; a staff member working "
                                             "half-time counts as 0.5 of an employee. Please include yourself in your "
                                             "organization's employee count. We asked a similar question on the last "
                                             "page, but here we are asking for the number of employees at the end of "
                                             "your last fiscal year instead of your current number."),
            "total_revenue": ugettext_noop("Revenue is the total amount of money your organization receives, regardless"
                                           "of the source of that funding. Sources of revenue may include fees for "
                                           "services and goods, government contracts, donations, grants, or investment "
                                           "income."),
            "total_donations": ugettext_noop("Donations and grants are two different sources of revenue. A donation is"
                                             " funding given to your organization with nothing or very little "
                                             "expected in return. An unrestricted cash gift from a private individual"
                                             " is a donation. A grant is funding given to your organization for a"
                                             " particular purpose with some obligations, such as reporting.  Revenue"
                                             " from government sources should also be included in this line."),
            "total_expenses": ugettext_noop("An expense is money your organization spends in order to deliver its "
                                            "programs, operate the business, and generate revenue. Expenses may "
                                            "include. wages and salaries, rent, insurance, travel, or supplies."),
            "total_program_expenses": ugettext_noop("A program expense is money your organization spends exclusively "
                                                    "in order to deliver its programs and should not include "
                                                    "administrative or fundraising expenses. These program expenses"
                                                    " should also be included in your total annual expenses for last "
                                                    "fiscal year above."),
        }

    def clean_actual_data(self):
        info_accuracy = self.cleaned_data['actual_data']

        if info_accuracy not in [True, False]:
            raise forms.ValidationError(ugettext_noop("Please select an option for Estimated or Actual Information"))

        return info_accuracy

    def clean_effective_date(self):
        last_fiscal_year_end_date = self.cleaned_data['effective_date']

        if not last_fiscal_year_end_date:
            raise forms.ValidationError(ugettext_noop(EMPTY_FIELD_ERROR.format("End date for Last Fiscal Year")))

        if last_fiscal_year_end_date > datetime.now().date():
            raise forms.ValidationError(ugettext_noop("Invalid Date"))

        return last_fiscal_year_end_date

    def clean_total_clients(self):
        total_clients = self.cleaned_data['total_clients']

        if not total_clients:
            raise forms.ValidationError(ugettext_noop(EMPTY_FIELD_ERROR.format("Total Client")))

        return total_clients

    def clean_total_employees(self):
        total_employees = self.cleaned_data['total_employees']

        if not total_employees:
            raise forms.ValidationError(ugettext_noop(EMPTY_FIELD_ERROR.format("Total Employees")))

        return total_employees

    def clean_local_currency(self):
        all_currency_codes = Currency.objects.values_list('alphabetic_code', flat=True)
        currency_input = self.cleaned_data['local_currency']

        if not currency_input in all_currency_codes:
            raise forms.ValidationError(ugettext_noop('Please select currency code.'))

        return currency_input

    def clean_total_revenue(self):
        total_revenue = self.cleaned_data['total_revenue']

        if not total_revenue:
            raise forms.ValidationError(ugettext_noop(EMPTY_FIELD_ERROR.format("Total Revenue")))

        return total_revenue

    def clean_total_donations(self):
        total_donations = self.cleaned_data['total_donations']

        if not total_donations:
            raise forms.ValidationError(ugettext_noop(EMPTY_FIELD_ERROR.format("Total Donations")))

        return total_donations

    def clean_total_expenses(self):
        total_expenses = self.cleaned_data['total_expenses']

        if not total_expenses:
            raise forms.ValidationError(ugettext_noop(EMPTY_FIELD_ERROR.format("Total Expenses")))

        return total_expenses

    def clean_total_program_expenses(self):
        total_program_expenses = self.cleaned_data['total_program_expenses']

        if not total_program_expenses:
            raise forms.ValidationError(ugettext_noop(EMPTY_FIELD_ERROR.format("Total Program Expense")))

        return total_program_expenses

    def save(self, request):
        user_extended_profile = request.user.extended_profile

        org_detail = super(OrganizationMetricModelForm, self).save(commit=False)
        org_detail.user = request.user
        org_detail.org = user_extended_profile.organization
        org_detail.local_currency = Currency.objects.filter(
            alphabetic_code=self.cleaned_data['local_currency']).first().alphabetic_code

        org_detail.save()

        if self.data['registration_number']:
            user_extended_profile.organization.registration_number = self.data['registration_number']
            user_extended_profile.organization.save()

        user_extended_profile.is_organization_metrics_submitted = True
        user_extended_profile.save()
