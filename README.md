# 🎗 Django-Rest Boilerplate

Quick start project template with Django Rest Framework.

## 🗞️ Tools inside

* Django Rest Framework
* Celery for asynchronous tasks
* PyTest as testing framework
* Gitlab CI config for deployments
* Local `.env` config (git-ignored by default, [the example](#📄-.env-file))
* Dockerfile for the project and for [static files serving](#📫-Dockerfile-&-Static-files)
* ⚠ [PurpleEntry](https://pe.toliak.ru/) as log collecting service
* ⚠ Deploy configs for [Nomad](https://www.nomadproject.io/)
* ⚠ WIP: ~~S3 Static and media~~

## 📑 Project structure

* `scripts` -- folder with bash scripts
* `myproject` -- django project
* `nomad` -- folder with nomad configs

## 📄 .env file

Example configuration file:

```shell
DB_DRIVER="django.db.backends.postgresql_psycopg2"
DB_HOST="127.0.0.1"
DB_NAME="db_name"
DB_PASSWORD="password"
DB_USERNAME="username"
DEBUG="True"
EMAIL_HOST="smtp.yandex.ru"
EMAIL_HOST_PASSWORD=""
EMAIL_HOST_USER=""
EMAIL_PORT="465"
EMAIL_TO="[\"a@toliak.ru\"]"
EMAIL_USE_TLS="True"
CELERY_BROKER_URL="amqp://username:password@127.0.0.1:5672"
SECRET_KEY="qb#j!0s4q!-54"
```

## 📫 Dockerfile & Static files

The [`Static.Dockerfile`](Static.Dockerfile) file can be used to 
serve static and media files. 