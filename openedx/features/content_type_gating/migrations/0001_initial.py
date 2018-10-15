# -*- coding: utf-8 -*-
# Generated by Django 1.11.15 on 2018-10-12 18:06
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('course_overviews', '0014_courseoverview_certificate_available_date'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('sites', '0002_alter_domain_unique'),
    ]

    operations = [
        migrations.CreateModel(
            name='CourseContentTypeGatingConfig',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('change_date', models.DateTimeField(auto_now_add=True, verbose_name='Change date')),
                ('enabled', models.NullBooleanField(default=None, verbose_name='Enabled')),
                ('enabled_after', models.DateTimeField()),
                ('changed_by', models.ForeignKey(editable=False, null=True, on_delete=django.db.models.deletion.PROTECT, to=settings.AUTH_USER_MODEL, verbose_name='Changed by')),
                ('course', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, to='course_overviews.CourseOverview')),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='GlobalContentTypeGatingConfig',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('change_date', models.DateTimeField(auto_now_add=True, verbose_name='Change date')),
                ('enabled', models.NullBooleanField(default=None, verbose_name='Enabled')),
                ('enabled_after', models.DateTimeField()),
                ('changed_by', models.ForeignKey(editable=False, null=True, on_delete=django.db.models.deletion.PROTECT, to=settings.AUTH_USER_MODEL, verbose_name='Changed by')),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='OrgContentTypeGatingConfig',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('change_date', models.DateTimeField(auto_now_add=True, verbose_name='Change date')),
                ('enabled', models.NullBooleanField(default=None, verbose_name='Enabled')),
                ('org', models.CharField(db_index=True, max_length=255)),
                ('enabled_after', models.DateTimeField()),
                ('changed_by', models.ForeignKey(editable=False, null=True, on_delete=django.db.models.deletion.PROTECT, to=settings.AUTH_USER_MODEL, verbose_name='Changed by')),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='SiteContentTypeGatingConfig',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('change_date', models.DateTimeField(auto_now_add=True, verbose_name='Change date')),
                ('enabled', models.NullBooleanField(default=None, verbose_name='Enabled')),
                ('enabled_after', models.DateTimeField()),
                ('changed_by', models.ForeignKey(editable=False, null=True, on_delete=django.db.models.deletion.PROTECT, to=settings.AUTH_USER_MODEL, verbose_name='Changed by')),
                ('site', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='sites.Site')),
            ],
            options={
                'abstract': False,
            },
        ),
    ]
