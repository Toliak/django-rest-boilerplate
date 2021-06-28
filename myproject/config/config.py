import json
import os

import environ

from pe_hook.pe import capture_exception

# reading .env file
environ.Env.read_env()

DEBUG = (os.getenv('APP_DEBUG') == 'True')

DB_AUTH = dict(
    driver=os.getenv('DB_DRIVER'),
    username=os.getenv('DB_USERNAME'),
    password=os.getenv('DB_PASSWORD'),
    name=os.getenv('DB_NAME'),
    host=os.getenv('DB_HOST'),
)

SECRET_KEY = os.getenv('SECRET_KEY')

EMAIL_HOST = os.getenv('EMAIL_HOST')
EMAIL_PORT = os.getenv('EMAIL_PORT')
EMAIL_HOST_USER = os.getenv('EMAIL_HOST_USER')
EMAIL_HOST_PASSWORD = os.getenv('EMAIL_HOST_PASSWORD')
EMAIL_USE_TLS = (os.getenv('EMAIL_USE_TLS') == 'True')
try:
    EMAIL_TO = json.loads(os.getenv('EMAIL_TO')) if os.getenv(
        'EMAIL_TO') else []
except json.JSONDecodeError as e:
    capture_exception(e)
    raise Exception(str(e) + '. Origin: "' + os.getenv('EMAIL_TO') + '"')

# For async tasks
CELERY_BROKER_URL = os.getenv('CELERY_BROKER_URL')

# S3
AWS_ACCESS_KEY_ID = os.getenv('AWS_ACCESS_KEY')
AWS_SECRET_ACCESS_KEY = os.getenv('AWS_SECRET_KEY')
AWS_STORAGE_BUCKET_NAME = os.getenv('AWS_BUCKET_NAME')
AWS_S3_ENDPOINT_URL = os.getenv('AWS_ENDPOINT_URL')