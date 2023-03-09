# Generated by Django 3.2.18 on 2023-03-10 01:38

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import opaque_keys.edx.django.models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='StagedContent',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('created', models.DateTimeField(auto_now_add=True)),
                ('purpose', models.CharField(choices=[('clipboard', 'Clipboard')], max_length=32)),
                ('status', models.CharField(choices=[('loading', 'Loading'), ('ready', 'Ready'), ('expired', 'Expired'), ('error', 'Error')], max_length=20)),
                ('block_type', models.CharField(help_text='\n            What type of content is staged. Only OLX content is supported, and\n            this field must be the same as the root tag of the OLX.\n            e.g. "video" if a video is staged, or "vertical" for a unit.\n        ', max_length=100)),
                ('olx', models.TextField()),
                ('display_name', models.CharField(max_length=1024)),
                ('source_context', opaque_keys.edx.django.models.LearningContextKeyField(max_length=255)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
