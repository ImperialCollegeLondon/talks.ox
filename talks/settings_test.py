from talks.settings import *

DEBUG = True

RAVEN_CONFIG = {}

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': ':memory:',
    }
}

API_OX_URL = '/static/mock/oxpoints.json'
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
