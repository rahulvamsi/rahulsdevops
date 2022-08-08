

StatusCheck(){
  if [ $? -eq 0 ]; then
    echo  " success"
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
cd /home/roboshop &>>/tmp/${COMPONENT}.log
rm -rf ${COMPONENT} &>>/tmp/${COMPONENT}.log
StatusCheck

}