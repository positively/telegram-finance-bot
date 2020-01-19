FROM python:3.8

WORKDIR /home

ENV TELEGRAM_API_TOKEN=""
ENV TELEGRAM_ACCESS_ID=""
ENV TELEGRAM_PROXY_URL=""
ENV TELEGRAM_PROXY_LOGIN=""
ENV TELEGRAM_PROXY_PASSWORD=""

RUN pip install -U pip aiogram pytz gspread oauth2client
RUN apt-get update && apt-get install sqlite3

COPY env/*.json ./env/
COPY *.py ./
COPY createdb.sql ./

ENTRYPOINT ["python", "server.py"]

# Docker build
# docker build -t tfb_r:0.0.2 ./
#
# Docker run
# docker run -d --name tfb_r -v 'C:\Users\rakst\Documents\Work\ViaRbot\tfb\db':/home/db --env-file env/env.list tfb_r:0.0.2
# docker run -d --name tfb_r -v /home/rostislavs/tfb/db:/home/db --env-file env/env.list tfb_r:0.0.2
# docker run -d --name tfb_v -v '/home/rostislavs/tfb/db-2':/home/db --env-file env/env-2.list tfb_r:0.0.2
