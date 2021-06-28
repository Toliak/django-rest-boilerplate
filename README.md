# 🎗 Django-Rest Boilerplate

Quick start project template with Django Rest Framework.

## 🗞️ Tools inside

* Django Rest Framework
* [StdImage](https://github.com/codingjoe/django-stdimage)
  , [Summernote](https://github.com/summernote/django-summernote) for Django
  Admin
* Configuration for email sending
* [Django DBBackup](https://django-dbbackup.readthedocs.io/en/master/index.html) for quick
  backups
* Celery for asynchronous tasks
* PyTest as testing framework
* Gitlab CI config for deployments
  - Docker Image into the private docker registry
  - Delivery into K8S Rancher
* Local `.env` config (git-ignored by default, [the example](#-env-file))
* Dockerfile for the project and
  for [static files serving](#-dockerfile--static-files)
* Localization files
* S3 for Media, Static and Backups
* ⚠ [PurpleEntry](https://pe.toliak.ru/) as log collecting service

## ❓ How to setup the project

1. Clone the project
2. Replace `myproject` by your name of the project (and renames files, folders)

## 📑 Project structure

* `scripts` -- folder with bash scripts
* `myproject` -- django project

## 📄 .env file

`.env` file should be located in `myproject/config/.env`.

Example file located [here](myproject/config/.env.sample)

Example configuration file

## 📫 Static files

AWS S3 storage can be used for serving static and media files.

# CI CD Guide

CI CD Prepared for Gitlab CI.

## Variables

### `gitlab-ci.yml`

|Name|Description|Example|
|---|---|---|
|RANCHER_URL|URL to rancher|`https://rancher.int.toliak.ru`|
|RANCHER_DEPLOYMENT|(Optional) Deployment name|`my-deployment`|
|DOCKER_IMAGE|Image with tag|`$CI_PROJECT_NAME:$CI_COMMIT_SHORT_SHA`|
|REGISTRY_URL|Url to Docker Registry|`registry.toliak.ru`|
|K8S_SECRETS|Secret path in K8S|`my-project`|
|K8S_SECRETS_REGISTRY|Secret path registry in K8S|`my-registry`|

### Project 

|Name|Description|Example|
|---|---|---|
|RANCHER_TOKEN|Rancher API **Bearer** Token|`token-adfsdf:asdijasd...iasjd`|
|REGISTRY_USERNAME|Docker Registry Username|`asdadasd`|
|REGISTRY_PASSWORD|Docker Registry Password|`asdasdas`|

# Backups

Using `django-dbbackup`.
Backup will be stored into S3 Bucket.
