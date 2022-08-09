#!/usr/bin/env bash
COMPONENT=redis
source Common.sh
DOWNLOAD

echo INSTALLING REDIS DEPENDENCIES
yum install redis -y &>>${LOG}
StatusCheck

echo CONFIGURING SYSTEMD
systemctl enable redis && systemctl start redis &>>${LOG}
StatusCheck