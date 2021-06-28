FROM python:3.9.5-slim-buster

WORKDIR /project/
COPY requirements.txt requirements.txt

RUN apt-get update -y && \
    apt-get -y install gnupg2 \
                       wget \
                       lsb-release && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list && \
    apt-get update -y && \
    apt-get install -y gcc \
                       libpq-dev \
                       python3-dev \
                       gettext \
                       postgresql-client-13 && \
    pip install -r requirements.txt && \
    apt-get remove -y gcc \
                      wget \
                      lsb-release && \
    apt-get clean all

COPY . /project/

RUN export SECRET_KEY=not_secret && \
    python manage.py compilemessages && \
    touch /project/myproject/config/.env

## Uncomment for default media and backup storage (filesystem)
#VOLUME ["/project/media"]
#VOLUME ["/project/backups"]
#
#RUN export SECRET_KEY=not_secret && \
#    python manage.py collectstatic --noinput

EXPOSE 8000

ENTRYPOINT ["./scripts/run-start.sh"]
