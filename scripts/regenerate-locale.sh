#! /bin/sh

set -e

# TODO: insert your locale, instead of `ru`
python manage.py makemessages --locale=ru --ignore=venv/*
