# -*- coding: utf-8 -*-
# Generated by Django 1.11.16 on 2018-11-28 19:07


from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('content_type_gating', '0002_auto_20181119_0959'),
    ]

    operations = [
        migrations.AlterField(
            model_name='contenttypegatingconfig',
            name='enabled_as_of',
            field=models.DateTimeField(blank=True, default=None, help_text='If the configuration is Enabled, then all enrollments created after this date (UTC) will be affected.', null=True, verbose_name='Enabled As Of'),
        ),
    ]
