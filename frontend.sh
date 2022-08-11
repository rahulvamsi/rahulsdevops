COMPONENT=frontend
source Common.sh
echo INSTALLING NGINX SERVICE
yum install nginx -y &>>${LOG}
StatusCheck
echo STARTING NGINX WITH SYSTEMCTL
systemctl enable nginx &>>${LOG}
systemctl start nginx &>>${LOG}
StatusCheck
#curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
DOWNLOAD
echo CHANGING AND REMOVING
cd /usr/share/nginx/html &>>${LOG} && rm -rf * &>>${LOG}
echo  UNZIPPING
unzip /tmp/frontend.zip &>>${LOG}
StatusCheck
echo moving files
mv frontend-main/static/* . &>>${LOG} && mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
StatusCheck
echo changing localhost to
sed -i -e '14 s/localhost/catalogue_dev/' -e  '16 s/localhost/user_dev/' -e  '18 s/localhost/cart_dev/' -e  '20 s/localhost/shipping_dev/' -e  '22 s/localhost/payment_dev/' /etc/nginx/default.d/roboshop.conf
StatusCheck

echo Starting ${COMPONENT} Service
systemctl start ${COMPONENT} &>>${LOG} && systemctl enable ${COMPONENT} &>>${LOG}
StatusCheck

echo restarting service nginx
systemctl restart nginx
StatusCheck
