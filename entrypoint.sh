#!/bin/sh

DOCKER_USER=app
DOCKER_HOME=/home/app

cp /.fetchmailrc $DOCKER_HOME/.fetchmailrc
cp /.pmmlrc $DOCKER_HOME/.pmmlrc

chown app $DOCKER_HOME/.fetchmailrc
chown app $DOCKER_HOME/.pmmlrc
chmod 700 $DOCKER_HOME/.fetchmailrc

exec runuser -u $DOCKER_USER -- fetchmail -d $POLL_INTERVAL -N
