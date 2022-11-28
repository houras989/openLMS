# Generated by Django 2.2.25 on 2022-11-28 15:56

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('genplus_learning', '0003_auto_20221118_1425'),
    ]

    operations = [
        migrations.AlterUniqueTogether(
            name='programunitenrollment',
            unique_together=None,
        ),
        migrations.RemoveField(
            model_name='programunitenrollment',
            name='course',
        ),
        migrations.RemoveField(
            model_name='programunitenrollment',
            name='course_enrollment',
        ),
        migrations.RemoveField(
            model_name='programunitenrollment',
            name='program_enrollment',
        ),
        migrations.DeleteModel(
            name='HistoricalProgramUnitEnrollment',
        ),
        migrations.DeleteModel(
            name='ProgramUnitEnrollment',
        ),
    ]
