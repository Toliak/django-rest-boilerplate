import pytest


@pytest.fixture(autouse=True)
def django_settings_language(settings):
    settings.LANGUAGE_CODE = 'en-us'
    settings.MEDIA_ROOT = 'media/test'


@pytest.fixture
def django_settings_mail(settings):
    settings.EMAIL_BACKEND = 'django.core.mail.backends.locmem.EmailBackend'
