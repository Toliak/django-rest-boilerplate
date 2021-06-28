#! /bin/sh

set -e

celery -A myproject.core worker \
       --loglevel=INFO
