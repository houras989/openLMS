# -*- coding: utf-8 -*-
# Generated by Django 1.11.16 on 2018-12-21 10:40
from __future__ import absolute_import, unicode_literals

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models

import openedx.core.djangolib.model_mixins


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('student', '0018_remove_password_history'),
    ]

    operations = [
        migrations.CreateModel(
            name='PendingSecondaryEmailChange',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('new_secondary_email', models.CharField(blank=True, db_index=True, max_length=255)),
                ('activation_key', models.CharField(db_index=True, max_length=32, unique=True, verbose_name=u'activation key')),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            bases=(openedx.core.djangolib.model_mixins.DeletableByUserValue, models.Model),
        ),
        migrations.AddField(
            model_name='accountrecovery',
            name='is_active',
            field=models.BooleanField(default=False),
        ),
    ]
