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
echo restarting service nginx
systemctl restart nginx
StatusCheck
