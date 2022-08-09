#!/usr/bin/env bash
COMPONENT=redis
source Common.sh
DOWNLOAD

echo INSTALLING REDIS DEPENDENCIES
yum install redis -y &>>${LOG}
StatusCheck

echo changing ip to 0
sed -i  's/127.0.0.1/0.0.0.0/' /etc/redis.conf &>>${LOG} && sed -i  's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
StatusCheck
echo CONFIGURING SYSTEMD
systemctl enable redis && systemctl start redis &>>${LOG}
StatusCheck