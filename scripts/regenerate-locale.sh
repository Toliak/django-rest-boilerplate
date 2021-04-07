#! /bin/sh

set -e

python manage.py makemessages --locale=ru --ignore=venv/*
