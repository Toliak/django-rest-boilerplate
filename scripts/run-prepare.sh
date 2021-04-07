#! /bin/sh

set -e

echo Migrating...
python manage.py migrate

# Unfortunately, backup cannot be created without migrations
echo Creating backup...
mkdir -p backups
./manage.py archive

echo Regenerating STDImage variations...

# TODO: insert your image models here
# Example below:
./manage.py rendervariations "core.CatalogItemImage.image" -i
