FROM python:3.11.1-alpine3.17

RUN adduser -D app && apk update && apk add fetchmail runuser

COPY ./requirements.txt /home/app/requirements.txt
COPY ./pmml.py /home/app/pmml.py
COPY ./entrypoint.sh /home/app/entrypoint.sh

ENV POLL_INTERVAL=60
RUN pip install -r /home/app/requirements.txt 

CMD ["/home/app/entrypoint.sh"]
