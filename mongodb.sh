#!/usr/bin/env bash
COMPONENT=mongodb
source Common.sh

echo Setup YUM repo
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>${LOG}
StatusCheck

yum install -y mongodb-org

echo configuring systemd
systemctl enable mongod && systemctl start mongod && systemctl restart mongod
StatusCheck
echo changing ip to 0
sed -i  's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${LOG}
StatusCheck
DOWNLOAD
echo INSTALLING NODEJS DEPENDENCIES
cd /tmp &>>${LOG} && rm -rf mongodb &>>${LOG} && unzip -o mongodb.zip &>>${LOG} && cd mongodb-main &>>${LOG}
StatusCheck
echo GETTING  FILE DATA IN MONGODB
mongo < catalogue.js &>>${LOG} &&mongo < users.js &>>${LOG}
StatusCheck









