# -*- coding: utf-8 -*-
# Generated by Django 1.11.16 on 2018-11-27 20:53


from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('grades', '0013_persistentsubsectiongradeoverride'),
    ]

    operations = [
        migrations.CreateModel(
            name='PersistentSubsectionGradeOverrideHistory',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('override_id', models.IntegerField(db_index=True)),
                ('feature', models.CharField(choices=[(b'PROCTORING', b'proctoring'), (b'GRADEBOOK', b'gradebook')], default=b'PROCTORING', max_length=32)),
                ('action', models.CharField(choices=[(b'CREATEORUPDATE', b'create_or_update'), (b'DELETE', b'delete')], default=b'CREATEORUPDATE', max_length=32)),
                ('comments', models.CharField(blank=True, max_length=300, null=True)),
                ('created', models.DateTimeField(auto_now_add=True, db_index=True)),
                ('user', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
