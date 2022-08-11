#COMPONENT=frontend
#source Common.sh
#echo INSTALLING NGINX SERVICE
#yum install nginx -y &>>${LOG}
#StatusCheck
#
##curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
#DOWNLOAD
#echo CHANGING AND REMOVING
#cd /usr/share/nginx/html &>>${LOG} && rm -rf * &>>${LOG}
#echo  UNZIPPING
#unzip /tmp/frontend.zip &>>${LOG}
#StatusCheck
#echo moving files
#mv frontend-main/static/* . &>>${LOG} && mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
#StatusCheck
#echo changing localhost to
#sed -i -e '14 s/localhost/catalogue_dev/' -e  '16 s/localhost/user_dev/' -e  '18 s/localhost/cart_dev/' -e  '20 s/localhost/shipping_dev/' -e  '22 s/localhost/payment_dev/' /etc/nginx/default.d/roboshop.conf
#StatusCheck
#
#
#echo STARTING NGINX WITH SYSTEMCTL
#systemctl enable nginx &>>${LOG}
#systemctl start nginx &>>${LOG}
#StatusCheck
#
#echo restarting service nginx
#systemctl restart nginx
#StatusCheck


#!/usr/bin/bash

# RoboShop - Frontend Setup

COMPONENT=frontend
source Common.sh

echo Installing Nginx
yum install nginx -y &>>${LOG}
StatusCheck

DOWNLOAD

echo Clean Old Content
cd /usr/share/nginx/html && rm -rf *
StatusCheck

echo Extract Downloaded Content
unzip -o /tmp/frontend.zip &>>${LOG} && mv frontend-main/static/* . &&  mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf
StatusCheck

echo Updating Nginx Configuration
sed -i -e '/catalogue/ s/localhost/catalogue-dev.roboshop.internal/' -e '/cart/ s/localhost/cart-dev.roboshop.internal/' -e '/user/ s/localhost/user-dev.roboshop.internal/' -e '/shipping/ s/localhost/shipping-dev.roboshop.internal/' -e '/payment/ s/localhost/payment-dev.roboshop.internal/' /etc/nginx/default.d/roboshop.conf
StatusCheck

echo Start Nginx Service
systemctl restart nginx &>>${LOG} && systemctl enable nginx &>>${LOG}
StatusCheck



