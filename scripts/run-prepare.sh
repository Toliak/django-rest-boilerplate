#! /bin/sh

set -e

echo Creating backup...
python manage.py dbbackup
python manage.py mediabackup

echo Migrating...
python manage.py migrate

echo Regenerating STDImage variations...

# TODO: insert your image models here
# Example below:
./manage.py rendervariations "core.CatalogItemImage.image" -i

echo Collecting static...
python manage.py collectstatic --noinput
