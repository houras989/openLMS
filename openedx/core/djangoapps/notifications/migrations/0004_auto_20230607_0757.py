# Generated by Django 3.2.19 on 2023-06-07 07:57

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone
import model_utils.fields
import opaque_keys.edx.django.models
import openedx.core.djangoapps.notifications.models


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('notifications', '0003_alter_notification_app_name'),
    ]

    operations = [
        migrations.CreateModel(
            name='CourseNotificationPreference',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created', model_utils.fields.AutoCreatedField(default=django.utils.timezone.now, editable=False, verbose_name='created')),
                ('modified', model_utils.fields.AutoLastModifiedField(default=django.utils.timezone.now, editable=False, verbose_name='modified')),
                ('course_id', opaque_keys.edx.django.models.CourseKeyField(max_length=255)),
                ('notification_preference_config', models.JSONField(default=openedx.core.djangoapps.notifications.models.get_course_notification_preference_config)),
                ('config_version', models.IntegerField(default=openedx.core.djangoapps.notifications.models.get_course_notification_preference_config_version)),
                ('is_active', models.BooleanField(default=True)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='notification_preferences', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'unique_together': {('user', 'course_id')},
            },
        ),
        migrations.RemoveField(
            model_name='notification',
            name='content',
        ),
        migrations.AddField(
            model_name='notification',
            name='course_id',
            field=opaque_keys.edx.django.models.CourseKeyField(blank=True, max_length=255, null=True),
        ),
        migrations.AlterField(
            model_name='notification',
            name='app_name',
            field=models.CharField(db_index=True, max_length=64),
        ),
        migrations.AlterField(
            model_name='notification',
            name='content_context',
            field=models.JSONField(default=dict),
        ),
        migrations.AlterField(
            model_name='notification',
            name='notification_type',
            field=models.CharField(max_length=64),
        ),
        migrations.DeleteModel(
            name='NotificationPreference',
        ),
    ]
