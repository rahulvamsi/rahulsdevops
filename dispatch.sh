
COMPONENT=dispatch
source Common.sh

echo INSTALLING GOLANG
yum install golang -y &>>${LOG}
StatusCheck
APP_USER_SETUP

echo Cleaning old application content
cd /home/roboshop &>>${LOG} && rm -rf ${COMPONENT} &>>${LOG}
StatusCheck

echo Extract Application Archive
unzip -o /tmp/dispatch.zip  && mv dispatch-main dispatch   && cd dispatch
StatusCheck
echo RUNNING GO SERVICE
go mod init dispatch &>>${LOG} && go get &>>${LOG} && go build &>>${LOG}
StatusCheck
SYSTEMD
