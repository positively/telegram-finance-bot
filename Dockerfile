FROM python:3.8

WORKDIR /home

ENV TELEGRAM_API_TOKEN=""
ENV TELEGRAM_ACCESS_ID=""
ENV TELEGRAM_PROXY_URL=""
ENV TELEGRAM_PROXY_LOGIN=""
ENV TELEGRAM_PROXY_PASSWORD=""

RUN pip install -U pip aiogram pytz && apt-get update && apt-get install sqlite3
COPY *.py ./
COPY createdb.sql ./

ENTRYPOINT ["python", "server.py"]

# Docker build
# docker build -t tfb_r ./
#
# Docker run
# docker run -d --name tfb_r -v 'db':/home/db --env-file env/env.list tfb_r
