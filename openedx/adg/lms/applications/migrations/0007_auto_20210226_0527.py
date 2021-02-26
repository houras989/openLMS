# Generated by Django 2.2.17 on 2021-02-26 05:27

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('course_overviews', '0022_courseoverviewtab_is_hidden'),
        ('applications', '0006_businessline_group'),
    ]

    operations = [
        migrations.CreateModel(
            name='MultilingualCourse',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('course', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='multilingual_course', to='course_overviews.CourseOverview', verbose_name='Multilingual version of a course')),
            ],
        ),
        migrations.CreateModel(
            name='MultilingualCourseGroup',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255, verbose_name='Course group name')),
                ('is_prerequisite', models.BooleanField(default=False, verbose_name='Is Prerequisite Course Group')),
            ],
        ),
        migrations.DeleteModel(
            name='PrerequisiteCourse',
        ),
        migrations.DeleteModel(
            name='PrerequisiteCourseGroup',
        ),
        migrations.AddField(
            model_name='multilingualcourse',
            name='multilingual_course_group',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='multilingual_courses', to='applications.MultilingualCourseGroup'),
        ),
    ]
