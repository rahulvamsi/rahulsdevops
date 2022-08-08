#!/usr/bin/env bash
source Common.sh

COMPONENT = catalogue

NodeJs

echo "unzipping"
unzip -o /tmp/catalogue.zip
StatusCheck
echo " moving and changing"
mv catalogue-main catalogue &>>/tmp/catalogue.log && cd catalogue &>>/tmp/catalogue.log
StatusCheck
echo "installing node "
npm install &>>/tmp/catalogue.log
StatusCheck
echo "moving systemd to catalogue"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>>/tmp/catalogue.log
StatusCheck
echo " running systemctl commands"
systemctl daemon-reload &>>/tmp/catalogue.log &&  systemctl start catalogue &>>/tmp/catalogue.log  && systemctl enable catalogue &>>/tmp/catalogue.log
StatusCheck