#!/usr/bin/env bash
COMPONENT=redis
source Common.sh
DOWNLOAD

echo INSTALLING REDIS DEPENDENCIES
yum install redis-6.2.7  -y &>>${LOG}
StatusCheck

echo CONFIGURING SYSTEMD
systemctl enable redis && systemctl start redis &>>${LOG}
StatusCheck