#! /bin/sh

set -e

celery -A myproject.core beat \
       --loglevel=INFO \
       --scheduler django_celery_beat.schedulers:DatabaseScheduler
