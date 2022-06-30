# Generated by Django 2.2.25 on 2022-06-30 13:55

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import django_extensions.db.fields
import opaque_keys.edx.django.models
import simple_history.models
import uuid


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('genplus', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('course_overviews', '0024_overview_adds_has_highlights'),
        ('student', '0041_registration_activation_timestamp'),
    ]

    operations = [
        migrations.CreateModel(
            name='Program',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created', django_extensions.db.fields.CreationDateTimeField(auto_now_add=True, verbose_name='created')),
                ('modified', django_extensions.db.fields.ModificationDateTimeField(auto_now=True, verbose_name='modified')),
                ('uuid', models.UUIDField(default=uuid.uuid4)),
                ('start_date', models.DateField()),
                ('end_date', models.DateField()),
                ('is_current', models.BooleanField(default=False)),
                ('units', models.ManyToManyField(blank=True, related_name='programs', to='course_overviews.CourseOverview')),
            ],
            options={
                'get_latest_by': 'modified',
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='ProgramEnrollment',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created', django_extensions.db.fields.CreationDateTimeField(auto_now_add=True, verbose_name='created')),
                ('modified', django_extensions.db.fields.ModificationDateTimeField(auto_now=True, verbose_name='modified')),
                ('status', models.CharField(choices=[('enrolled', 'enrolled'), ('pending', 'pending'), ('suspended', 'suspended'), ('canceled', 'canceled'), ('ended', 'ended')], max_length=9)),
                ('from_class', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='program_enrollments', to='genplus.Class')),
                ('gen_user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='program_enrollments', to='genplus.GenUser')),
                ('program', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='program_enrollments', to='genplus_learning.Program')),
            ],
            options={
                'unique_together': {('gen_user', 'program')},
            },
        ),
        migrations.CreateModel(
            name='YearGroup',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=128, unique=True)),
                ('program_name', models.CharField(max_length=128)),
            ],
        ),
        migrations.AddField(
            model_name='program',
            name='year_group',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='programs', to='genplus_learning.YearGroup'),
        ),
        migrations.CreateModel(
            name='Lesson',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('course_key', opaque_keys.edx.django.models.CourseKeyField(max_length=255)),
                ('usage_key', opaque_keys.edx.django.models.UsageKeyField(max_length=255)),
                ('is_locked', models.BooleanField(default=True)),
            ],
            options={
                'unique_together': {('course_key', 'usage_key')},
            },
        ),
        migrations.CreateModel(
            name='HistoricalProgramUnitEnrollment',
            fields=[
                ('id', models.IntegerField(auto_created=True, blank=True, db_index=True, verbose_name='ID')),
                ('created', django_extensions.db.fields.CreationDateTimeField(auto_now_add=True, verbose_name='created')),
                ('modified', django_extensions.db.fields.ModificationDateTimeField(auto_now=True, verbose_name='modified')),
                ('is_active', models.BooleanField(default=True)),
                ('history_id', models.AutoField(primary_key=True, serialize=False)),
                ('history_date', models.DateTimeField()),
                ('history_change_reason', models.CharField(max_length=100, null=True)),
                ('history_type', models.CharField(choices=[('+', 'Created'), ('~', 'Changed'), ('-', 'Deleted')], max_length=1)),
                ('course_enrollment', models.ForeignKey(blank=True, db_constraint=False, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to='student.CourseEnrollment')),
                ('history_user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='+', to=settings.AUTH_USER_MODEL)),
                ('program_enrollment', models.ForeignKey(blank=True, db_constraint=False, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to='genplus_learning.ProgramEnrollment')),
                ('unit', models.ForeignKey(blank=True, db_constraint=False, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to='course_overviews.CourseOverview')),
            ],
            options={
                'verbose_name': 'historical program unit enrollment',
                'ordering': ('-history_date', '-history_id'),
                'get_latest_by': 'history_date',
            },
            bases=(simple_history.models.HistoricalChanges, models.Model),
        ),
        migrations.CreateModel(
            name='HistoricalProgramEnrollment',
            fields=[
                ('id', models.IntegerField(auto_created=True, blank=True, db_index=True, verbose_name='ID')),
                ('created', django_extensions.db.fields.CreationDateTimeField(auto_now_add=True, verbose_name='created')),
                ('modified', django_extensions.db.fields.ModificationDateTimeField(auto_now=True, verbose_name='modified')),
                ('status', models.CharField(choices=[('enrolled', 'enrolled'), ('pending', 'pending'), ('suspended', 'suspended'), ('canceled', 'canceled'), ('ended', 'ended')], max_length=9)),
                ('history_id', models.AutoField(primary_key=True, serialize=False)),
                ('history_date', models.DateTimeField()),
                ('history_change_reason', models.CharField(max_length=100, null=True)),
                ('history_type', models.CharField(choices=[('+', 'Created'), ('~', 'Changed'), ('-', 'Deleted')], max_length=1)),
                ('from_class', models.ForeignKey(blank=True, db_constraint=False, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to='genplus.Class')),
                ('gen_user', models.ForeignKey(blank=True, db_constraint=False, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to='genplus.GenUser')),
                ('history_user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='+', to=settings.AUTH_USER_MODEL)),
                ('program', models.ForeignKey(blank=True, db_constraint=False, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to='genplus_learning.Program')),
            ],
            options={
                'verbose_name': 'historical program enrollment',
                'ordering': ('-history_date', '-history_id'),
                'get_latest_by': 'history_date',
            },
            bases=(simple_history.models.HistoricalChanges, models.Model),
        ),
        migrations.CreateModel(
            name='HistoricalProgram',
            fields=[
                ('id', models.IntegerField(auto_created=True, blank=True, db_index=True, verbose_name='ID')),
                ('created', django_extensions.db.fields.CreationDateTimeField(auto_now_add=True, verbose_name='created')),
                ('modified', django_extensions.db.fields.ModificationDateTimeField(auto_now=True, verbose_name='modified')),
                ('uuid', models.UUIDField(default=uuid.uuid4)),
                ('start_date', models.DateField()),
                ('end_date', models.DateField()),
                ('is_current', models.BooleanField(default=False)),
                ('history_id', models.AutoField(primary_key=True, serialize=False)),
                ('history_date', models.DateTimeField()),
                ('history_change_reason', models.CharField(max_length=100, null=True)),
                ('history_type', models.CharField(choices=[('+', 'Created'), ('~', 'Changed'), ('-', 'Deleted')], max_length=1)),
                ('history_user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='+', to=settings.AUTH_USER_MODEL)),
                ('year_group', models.ForeignKey(blank=True, db_constraint=False, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to='genplus_learning.YearGroup')),
            ],
            options={
                'verbose_name': 'historical program',
                'ordering': ('-history_date', '-history_id'),
                'get_latest_by': 'history_date',
            },
            bases=(simple_history.models.HistoricalChanges, models.Model),
        ),
        migrations.CreateModel(
            name='HistoricalClassEnrollment',
            fields=[
                ('id', models.IntegerField(auto_created=True, blank=True, db_index=True, verbose_name='ID')),
                ('history_id', models.AutoField(primary_key=True, serialize=False)),
                ('history_date', models.DateTimeField()),
                ('history_change_reason', models.CharField(max_length=100, null=True)),
                ('history_type', models.CharField(choices=[('+', 'Created'), ('~', 'Changed'), ('-', 'Deleted')], max_length=1)),
                ('gen_class', models.ForeignKey(blank=True, db_constraint=False, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to='genplus.Class')),
                ('history_user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='+', to=settings.AUTH_USER_MODEL)),
                ('program', models.ForeignKey(blank=True, db_constraint=False, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to='genplus_learning.Program')),
            ],
            options={
                'verbose_name': 'historical class enrollment',
                'ordering': ('-history_date', '-history_id'),
                'get_latest_by': 'history_date',
            },
            bases=(simple_history.models.HistoricalChanges, models.Model),
        ),
        migrations.CreateModel(
            name='ProgramUnitEnrollment',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created', django_extensions.db.fields.CreationDateTimeField(auto_now_add=True, verbose_name='created')),
                ('modified', django_extensions.db.fields.ModificationDateTimeField(auto_now=True, verbose_name='modified')),
                ('is_active', models.BooleanField(default=True)),
                ('course_enrollment', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='student.CourseEnrollment')),
                ('program_enrollment', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='program_unit_enrollments', to='genplus_learning.ProgramEnrollment')),
                ('unit', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='course_overviews.CourseOverview')),
            ],
            options={
                'unique_together': {('program_enrollment', 'unit')},
            },
        ),
        migrations.CreateModel(
            name='ClassEnrollment',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('gen_class', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='class_enrollments', to='genplus.Class')),
                ('program', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='class_enrollments', to='genplus_learning.Program')),
            ],
            options={
                'unique_together': {('gen_class', 'program')},
            },
        ),
    ]
