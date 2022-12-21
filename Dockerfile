FROM python:3.11.1-alpine3.17

RUN adduser -D app && apk update && apk add fetchmail runuser

COPY ./requirements.txt /home/app/requirements.txt
COPY ./pmml.py /home/app/pmml.py
COPY ./entrypoint.sh /home/app/entrypoint.sh

RUN pip install -r /home/app/requirements.txt 

ENTRYPOINT ["/home/app/entrypoint.sh"]
