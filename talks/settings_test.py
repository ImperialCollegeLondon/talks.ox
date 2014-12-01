from talks.settings import *

INSTALLED_APPS += ('django_nose',)
TEST_RUNNER = 'django_nose.NoseTestSuiteRunner'
DEBUG = True

RAVEN_CONFIG = {}

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': ':memory:',
    }
}

AUTHENTICATION_BACKENDS = (
    'django.contrib.auth.backends.ModelBackend',
)

API_OX_PLACES_URL = '/static/mock/oxpoints.json'
API_OX_DATES_URL = API_OX_PLACES_URL    # faking the response for dates
TOPICS_URL = '/static/mock/topics.json?'

CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.dummy.DummyCache',
    },
    'oxpoints': {
        'BACKEND': 'django.core.cache.backends.dummy.DummyCache',
    },
    'topics': {
        'BACKEND': 'django.core.cache.backends.dummy.DummyCache',
    },
}

DEBUG = True
TEMPLATE_DEBUG = DEBUG
