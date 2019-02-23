# -*- coding: utf-8 -*-
# Generated by Django 1.11.12 on 2018-04-11 15:20


from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone
import model_utils.fields


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('verify_student', '0005_remove_deprecated_models'),
    ]

    operations = [
        migrations.CreateModel(
            name='SSOVerification',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('status', model_utils.fields.StatusField(choices=[(b'created', b'created'), (b'ready', b'ready'), (b'submitted', b'submitted'), (b'must_retry', b'must_retry'), (b'approved', b'approved'), (b'denied', b'denied')], default=b'created', max_length=100, no_check_for_status=True, verbose_name='status')),
                ('status_changed', model_utils.fields.MonitorField(default=django.utils.timezone.now, monitor='status', verbose_name='status changed')),
                ('name', models.CharField(blank=True, max_length=255)),
                ('created_at', models.DateTimeField(auto_now_add=True, db_index=True)),
                ('updated_at', models.DateTimeField(auto_now=True, db_index=True)),
                ('identity_provider_type', models.CharField(choices=[(b'third_party_auth.models.OAuth2ProviderConfig', b'OAuth2 Provider'), (b'third_party_auth.models.SAMLProviderConfig', b'SAML Provider'), (b'third_party_auth.models.LTIProviderConfig', b'LTI Provider')], default=b'third_party_auth.models.SAMLProviderConfig', help_text=b'Specifies which type of Identity Provider this verification originated from.', max_length=100)),
                ('identity_provider_slug', models.SlugField(default=b'default', help_text=b'The slug uniquely identifying the Identity Provider this verification originated from.', max_length=30)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
