from pe_hook.pe import capture_exception
from .config import *

try:
    DB_AUTH
except NameError as e:
    capture_exception(e)
    raise NameError("""DB_AUTH is not defined. Example:
DB_AUTH = dict(
    username='username',
    password='password',
    name='database_name',
    address='127.0.0.1',
)""")

try:
    DEBUG
except NameError as e:
    capture_exception(e)
    raise NameError("""DEBUG is not defined.""")

try:
    SECRET_KEY
except NameError as e:
    capture_exception(e)
    raise NameError("""SECRET_KEY is not defined. Use:
from django.core.management.utils import get_random_secret_key  
... get_random_secret_key()""")

try:
    EMAIL_HOST
except NameError as e:
    capture_exception(e)
    raise NameError("""EMAIL_HOST is not defined.""")

try:
    CELERY_BROKER_URL
except NameError as e:
    capture_exception(e)
    raise NameError("""CELERY_BROKER_URL is not defined.""")
