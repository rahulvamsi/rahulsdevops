#!/usr/bin/env bash
source Common.sh

COMPONENT = catalogue

NodeJs

echo "unzipping"
unzip -o /tmp/catalogue.zip
StatusCheck
ls
echo " moving and changing"
mv catalogue-main  catalogue
cd catalogue
StatusCheck
echo "installing node "
npm install &>>/tmp/catalogue.log
StatusCheck
echo "moving systemd to catalogue"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
systemctl daemon-reload
StatusCheck

echo " running systemctl commands"
systemctl start catalogue &>>/tmp/catalogue.log  && systemctl enable catalogue &>>/tmp/catalogue.log
StatusCheck