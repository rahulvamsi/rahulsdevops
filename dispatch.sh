#set -e
#yum install golang -y
#useradd roboshop
#rm -rf dispatch
#curl -L -s -o /tmp/dispatch.zip https://github.com/roboshop-devops-project/dispatch/archive/refs/heads/main.zip
#unzip -o /tmp/dispatch.zip
#mv dispatch-main dispatch
#cd dispatch
#go mod init dispatch
#go get
#go build
#mv /home/roboshop/dispatch/systemd.service /etc/systemd/system/dispatch.service
#systemctl daemon-reload
#systemctl enable dispatch
#systemctl start dispatch
#



#!/usr/bin/env bash
COMPONENT=dispatch
source Common.sh

echo INSTALLING GOLANG
yum install golang -y &>>${LOG}
StatusCheck
APP_USER_SETUP
#cd /home/roboshop && rm -rf dispatch
#curl -L -s -o /tmp/dispatch.zip https://github.com/roboshop-devops-project/dispatch/archive/refs/heads/main.zip
#unzip -o /tmp/dispatch.zip && mv dispatch-main dispatch && cd dispatch
APP_CLEAN
echo RUNNING GO SERVICE
go mod init dispatch &>>${LOG} && go get &>>${LOG} && go build &>>${LOG}
StatusCheck
SYSTEMD
