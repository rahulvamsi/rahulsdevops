#
#COMPONENT=dispatch
#source Common.sh
#
#echo INSTALLING GOLANG
#yum install golang -y &>>${LOG}
#StatusCheck
#APP_USER_SETUP
#
#echo Cleaning old application content
#cd /home/roboshop &>>${LOG} && rm -rf ${COMPONENT} &>>${LOG}
#StatusCheck
#
#echo Extract Application Archive
#unzip -o /tmp/dispatch.zip  && mv dispatch-main dispatch   && cd dispatch
#StatusCheck
#echo RUNNING GO SERVICE
#go mod init dispatch &>>${LOG} && go get &>>${LOG} && go build &>>${LOG}
#StatusCheck
#SYSTEMD

yum install golang -y
useradd roboshop

curl -L -s -o /tmp/dispatch.zip https://github.com/roboshop-devops-project/dispatch/archive/refs/heads/main.zip
unzip /tmp/dispatch.zip
mv dispatch-main dispatch
cd dispatch
go mod init dispatch
go get
go build


mv systemd.service dispatch.service
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch