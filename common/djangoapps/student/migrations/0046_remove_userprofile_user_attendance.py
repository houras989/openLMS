# Generated by Django 3.2.13 on 2022-06-09 05:42

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('student', '0045_auto_20220608_1751'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='userprofile',
            name='user_attendance',
        ),
    ]
