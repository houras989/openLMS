# -*- coding: utf-8 -*-
# Generated by Django 1.11.15 on 2019-03-05 02:35
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone
import model_utils.fields


class Migration(migrations.Migration):

    dependencies = [
        ('sites', '0002_alter_domain_unique'),
        ('certificates', '0014_change_eligible_certs_manager'),
    ]

    operations = [
        migrations.CreateModel(
            name='CertificatePdfConfig',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created', model_utils.fields.AutoCreatedField(default=django.utils.timezone.now, editable=False, verbose_name='created')),
                ('modified', model_utils.fields.AutoLastModifiedField(default=django.utils.timezone.now, editable=False, verbose_name='modified')),
                ('sentences', models.TextField()),
                ('canvas', models.TextField()),
                ('positions', models.TextField()),
                ('font_name', models.CharField(max_length=255)),
                ('font_info', models.TextField()),
                ('site', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='cert_pdf_configs', to='sites.Site')),
            ],
        ),
    ]
