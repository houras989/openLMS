# -*- coding: utf-8 -*-
# Generated by Django 1.11.14 on 2018-07-27 01:44


from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('student', '0015_manualenrollmentaudit_add_role'),
    ]

    operations = [
        migrations.AlterField(
            model_name='courseenrollment',
            name='course',
            field=models.ForeignKey(db_constraint=False, on_delete=django.db.models.deletion.DO_NOTHING, to='course_overviews.CourseOverview'),
        ),
    ]
