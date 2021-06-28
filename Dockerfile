FROM python:3.9.5-slim-buster

WORKDIR /project/
COPY requirements.txt requirements.txt

RUN apt-get update -y && \
    apt-get install -y gcc libpq-dev python3-dev gettext && \
    pip install -r requirements.txt && \
    apt-get remove -y gcc

COPY . /project/

RUN export SECRET_KEY=not_secret && \
    python manage.py compilemessages

## Uncomment for default media and backup storage (filesystem)
#VOLUME ["/project/media"]
#VOLUME ["/project/backups"]
#
#RUN export SECRET_KEY=not_secret && \
#    python manage.py collectstatic --noinput

EXPOSE 8000

ENTRYPOINT ["./scripts/run-start.sh"]
