"""
File containing common fixtures used across different test modules
"""
from datetime import datetime

import pytest

from openedx.adg.lms.applications.admin import UserApplicationADGAdmin, adg_admin_site
from openedx.adg.lms.applications.models import UserApplication

from .factories import EducationFactory, UserApplicationFactory, WorkExperienceFactory


@pytest.fixture
def education():
    return EducationFactory()


@pytest.fixture
def work_experience():
    return WorkExperienceFactory()


@pytest.fixture
def user_application():
    return UserApplicationFactory()


@pytest.fixture
def user_application_adg_admin_instance():
    return UserApplicationADGAdmin(UserApplication, adg_admin_site)


@pytest.fixture
def current_date():
    return datetime.now().date()
