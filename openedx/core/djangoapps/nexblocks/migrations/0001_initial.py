# Generated by Django 2.2.18 on 2021-02-06 18:57

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='NexBlockInstance',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('uuid', models.UUIDField(editable=False, unique=True)),
                ('display_name', models.CharField(max_length=255)),
            ],
        ),
        migrations.CreateModel(
            name='NexBlockInstanceLearnerDatum',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('data_key', models.CharField(max_length=255)),
                ('data_value', models.TextField()),
                ('instance', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='learner_data', to='nexblocks.NexBlockInstance')),
                ('learner', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'unique_together': {('instance', 'learner', 'data_key')},
            },
        ),
        migrations.CreateModel(
            name='NexBlockInstanceDatum',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('data_key', models.CharField(max_length=255)),
                ('data_value', models.TextField()),
                ('instance', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='instance_data', to='nexblocks.NexBlockInstance')),
            ],
            options={
                'unique_together': {('instance', 'data_key')},
            },
        ),
    ]
