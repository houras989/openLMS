# -*- coding: utf-8 -*-
# Generated by Django 1.11.21 on 2019-07-01 12:48
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('instructor_task', '0002_gradereportsetting'),
    ]

    operations = [
        migrations.AlterField(
            model_name='instructortask',
            name='task_input',
            field=models.TextField(),
        ),
    ]
