FROM python:3.7.8-slim-stretch

WORKDIR /project/
COPY requirements.txt requirements.txt

RUN apt-get update -y && \
    apt-get install -y gcc && \
    pip install -r requirements.txt && \
    apt-get remove -y gcc

COPY . /project/

RUN export SECRET_KEY=not_secret && \
    python manage.py collectstatic --noinput && \
    python manage.py compilemessages

VOLUME ["/project/media"]
VOLUME ["/project/backups"]

EXPOSE 8000

ENTRYPOINT ["./scripts/run-start.sh"]
