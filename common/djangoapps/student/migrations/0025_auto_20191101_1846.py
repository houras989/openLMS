# Generated by Django 1.11.25 on 2019-11-01 18:46


from django.db import migrations

from common.djangoapps.student.models import CourseEnrollment, FBEEnrollmentExclusion
from lms.djangoapps.experiments.models import ExperimentData
from openedx.features.course_duration_limits.config import EXPERIMENT_DATA_HOLDBACK_KEY, EXPERIMENT_ID


def populate_fbeenrollmentexclusion(apps, schema_editor):
    holdback_entries = ExperimentData.objects.filter(
        experiment_id=EXPERIMENT_ID,
        key=EXPERIMENT_DATA_HOLDBACK_KEY,
        value='True'
    )
    for holdback_entry in holdback_entries:
        enrollments = [FBEEnrollmentExclusion(enrollment=enrollment)
                       for enrollment in CourseEnrollment.objects.filter(user=holdback_entry.user)]
        if enrollments:
            FBEEnrollmentExclusion.objects.bulk_create(enrollments)


class Migration(migrations.Migration):

    dependencies = [
        ('student', '0024_fbeenrollmentexclusion'),
        ('experiments', '0001_initial'),
    ]

    operations = [
        migrations.RunPython(populate_fbeenrollmentexclusion, reverse_code=migrations.RunPython.noop),
    ]
