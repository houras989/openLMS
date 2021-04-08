# Generated by Django 1.11.28 on 2020-03-16 19:35


import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('schedules', '0018_readd_historicalschedule_fks'),
    ]

    operations = [
        migrations.AlterField(
            model_name='schedule',
            name='enrollment',
            field=models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to='student.CourseEnrollment'),
        ),
        migrations.AlterField(
            model_name='schedule',
            name='start_date',
            field=models.DateTimeField(db_index=True, default=None, help_text='Date this schedule went into effect', null=True),
        ),
        migrations.AlterField(
            model_name='scheduleexperience',
            name='schedule',
            field=models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='experience', to='schedules.Schedule'),
        ),
    ]
