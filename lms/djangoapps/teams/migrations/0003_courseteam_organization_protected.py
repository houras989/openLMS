# -*- coding: utf-8 -*-
# Generated by Django 1.11.25 on 2019-11-04 19:15
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('teams', '0002_slug_field_ids'),
    ]

    operations = [
        migrations.AddField(
            model_name='courseteam',
            name='organization_protected',
            field=models.BooleanField(default=False),
        ),
    ]
