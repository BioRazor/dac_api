FROM python:3.8-alpine
LABEL maintainer="David Abreu @biorazor"

ENV PYTHONUNBUFFERED=1

COPY ./requirements.txt /requirements.txt

# to install postgresql client with no cache, to mantain de container small and no extra deps
RUN apk add --update --no-cache postgresql-client
# virtual allow to create an alias to all the dependecies tu easily use and remove
RUN apk add --update --no-cache --virtual .tpm-build-deps \
    gcc libc-dev linux-headers postgresql-dev
# Project Requirements
RUN pip install -r /requirements.txt
# Remove temporary dependencies
RUN apk del .tpm-build-deps

RUN mkdir /app 
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user