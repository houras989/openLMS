# -*- coding: utf-8 -*-
# Generated by Django 1.11.12 on 2018-04-12 12:00
from __future__ import absolute_import, unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('entitlements', '0008_auto_20180328_1107'),
    ]

    operations = [
        migrations.AddField(
            model_name='courseentitlement',
            name='refund_locked',
            field=models.BooleanField(default=False),
        ),
    ]
