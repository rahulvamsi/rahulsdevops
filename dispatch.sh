
COMPONENT=dispatch
source Common.sh

echo INSTALLING GOLANG
yum install golang -y &>>${LOG}
StatusCheck
APP_USER_SETUP

#APP_CLEAN

echo Cleaning old application content
cd /home/roboshop  && rm -rf dispatch 
StatusCheck

echo Extract Application Archive
unzip -o /tmp/dispatch.zip   && mv dispatch-main ${COMPONENT}   && cd dispatch
StatusCheck

echo RUNNING GO SERVICE
go mod init dispatch &>>${LOG} && go get &>>${LOG} && go build &>>${LOG}
StatusCheck
SYSTEMD

