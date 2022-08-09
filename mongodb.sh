#!/usr/bin/env bash
COMPONENT=mongodb
source Common.sh
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>${LOG} && yum install -y mongodb-org &>>${LOG}
echo configuring systemd
systemctl enable mongod
systemctl start mongod
systemctl restart mongod
DOWNLOAD
echo INSTALLING NODEJS DEPENDENCIES
cd /tmp &>>${LOG} && rm -rf mongodb &>>${LOG} && unzip -o mongodb.zip &>>${LOG} && cd mongodb-main &>>${LOG}
echo GETTING  FILE DATA IN MONGODB
mongo < catalogue.js &>>${LOG} &&mongo < users.js &>>${LOG}









