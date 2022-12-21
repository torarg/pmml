FROM 3.11.1-alpine3.17

RUN adduser -D app && apk update && apk add fetchmail

USER app
WORKDIR /app

COPY ./requirements.txt ./requirements.txt

RUN pip install -r requirements.txt

ENTRYPOINT ["fetchmail"]
