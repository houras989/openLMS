# -*- coding: utf-8 -*-
# Generated by Django 1.11.20 on 2019-03-06 15:46
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('course_duration_limits', '0004_auto_20181128_1521'),
    ]

    operations = [
        migrations.AlterField(
            model_name='coursedurationlimitconfig',
            name='enabled_as_of',
            field=models.DateTimeField(blank=True, default=None, help_text='If the configuration is Enabled, then all enrollments created after this date and time (user local time) will be affected.', null=True, verbose_name='Enabled As Of'),
        ),
    ]
