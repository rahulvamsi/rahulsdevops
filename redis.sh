#!/usr/bin/env bash
COMPONENT=redis
source Common.sh
DOWNLOAD

echo INSTALLING REDIS DEPENDENCIES
yum install redis-6 -y &>>${LOG}
StatusCheck

echo changing ip to 0
sed -i  's/127.0.0.1/0.0.0.0/g' /etc/redis.conf /etc/redis/redis.conf &>>${LOG}
StatusCheck
echo CONFIGURING SYSTEMD
systemctl enable redis && systemctl start redis &>>${LOG}
StatusCheck