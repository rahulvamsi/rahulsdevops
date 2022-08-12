
COMPONENT=dispatch
source Common.sh

echo INSTALLING GOLANG
yum install golang -y &>>${LOG}
StatusCheck
APP_USER_SETUP
DOWNLOAD

APP_CLEAN

echo RUNNING GO SERVICE
go mod init dispatch &>>${LOG} && go get &>>${LOG} && go build &>>${LOG}
StatusCheck
echo CHANGING RABBITMQ-IP
sed -i -e 's/RABBITMQ-IP/rabbitmq_dev.roboshop.internal/' /etc/systemd/system/dispatch.service &>>${LOG} && systemctl daemon-reload &>>${LOG}
StatusCheck

SYSTEMD

