#!/bin/sh

DOCKER_USER=app
DOCKER_HOME=/home/app

chown app $DOCKER_HOME/.fetchmailrc
chown app $DOCKER_HOME/pmml.py
chown app $DOCKER_HOME/.pmmlrc
exec runuser -u $DOCKER_USER -- fetchmail -d 60 -N
