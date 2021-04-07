# 🎗 Django-Rest Boilerplate

Quick start project template with Django Rest Framework.

## 🗞️ Tools inside

* Django Rest Framework
* [StdImage](https://github.com/codingjoe/django-stdimage)
  , [Summernote](https://github.com/summernote/django-summernote) for Django
  Admin
* Configuration for email sending
* [Django Archive](https://github.com/nathan-osman/django-archive) for quick
  backups
* Celery for asynchronous tasks
* PyTest as testing framework
* Gitlab CI config for deployments
* Local `.env` config (git-ignored by default, [the example](#📄-.env-file))
* Dockerfile for the project and
  for [static files serving](#📫-Dockerfile-&-Static-files)
* ⚠ [PurpleEntry](https://pe.toliak.ru/) as log collecting service
* ⚠ Deploy configs for [Nomad](https://www.nomadproject.io/)
* ⚠ Uses [Vault](https://www.vaultproject.io/) as credentials store
* ⚠ WIP: ~~S3 Static and media~~

## How to setup the project

1. Clone the project
2. Replace `myproject` by your name of the project (and renames files, folders)

## 📑 Project structure

* `scripts` -- folder with bash scripts
* `myproject` -- django project
* `nomad` -- folder with nomad configs

## 📄 .env file

`.env` file should be located in `myproject/config/.env`.

Example file located [here](myproject/config/.env.sample)

Example configuration file

## 📫 Dockerfile & Static files

The [`Static.Dockerfile`](Static.Dockerfile) file can be used to serve static
and media files. 