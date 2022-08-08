

StatusCheck(){
  if [ $? -eq 0 ]; then
    echo  " sucess"
  else
    echo "failed"
    exit 1
  fi
}

NodeJs() {
  echo "downloading repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/${COMPONENT}.log
StatusCheck

echo "installing node"
yum install nodejs -y &>>/tmp/${COMPONENT}.log
StatusCheck

id roboshop &>>/tmp/${COMPONENT}.log

if [ $? -nq 0 ]; then
  echo "adding user"
  useradd roboshop &>>/tmp/${COMPONENT}.log
  StatusCheck
fi
echo "downloading zip file "
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>/tmp/${COMPONENT}.log
StatusCheck
echo "changing direct"
cd /home/roboshop &>>/tmp/${COMPONENT}.log &&  rm -rf ${COMPONENT} &>>/tmp/${COMPONENT}.log
StatusCheck
echo "unzipping"
unzip -o /tmp/catalogue.zip &>>/tmp/catalogue.log
StatusCheck
mv ${COMPONENT}-main ${COMPONENT} &>>/tmp/${COMPONENT}.log && cd ${COMPONENT} &>>/tmp/${COMPONENT}.log
StatusCheck
echo "installing node "
npm install &>>/tmp/${COMPONENT}.log
StatusCheck
echo "moving systemd to ${COMPONENT}"
mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service &>>/tmp/${COMPONENT}.log
StatusCheck
echo " running systemctl commands"
systemctl daemon-reload &>>/tmp/${COMPONENT}.log &&  systemctl start ${COMPONENT} &>>/tmp/${COMPONENT}.log  && systemctl enable ${COMPONENT} &>>/tmp/${COMPONENT}.log
StatusCheck
}