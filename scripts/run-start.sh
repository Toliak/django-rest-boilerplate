#! /bin/sh

set -e

DJANGO_WSGI_MODULE=myproject.wsgi
NUM_WORKERS=3
TIMEOUT=120

exec gunicorn ${DJANGO_WSGI_MODULE} \
              --workers $NUM_WORKERS \
              --timeout $TIMEOUT \
              --log-level=info \
              --bind=0.0.0.0:8000
