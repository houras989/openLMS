# -*- coding: utf-8 -*-
# Generated by Django 1.11.28 on 2020-02-25 16:46
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('third_party_auth', '0024_fix_edit_disallowed'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='providerapipermissions',
            name='client',
        ),
        migrations.DeleteModel(
            name='ProviderApiPermissions',
        ),
    ]
