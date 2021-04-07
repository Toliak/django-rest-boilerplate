#! /bin/sh

set -e

celery -A myproject worker  --loglevel=INFO \
                            --concurrency=2
