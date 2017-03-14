#!/bin/bash
source ./base.conf
echo $APPNAME
docker stop $APPNAME
docker rm $APPNAME
docker build . -t pack/php:latest
docker run -d -p $EXTERNAL_PORT:80 -p 3306:3306 --name $APPNAME pack/php:latest
echo $APPNAME is running on Docker port 80, bound to external port $EXTERNAL_PORT
