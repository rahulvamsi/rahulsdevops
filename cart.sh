#set -e
source Common.sh

echo "downloading repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/cart.log
StatusCheck

echo "installing node"
yum install nodejs -y &>>/tmp/cart.log
StatusCheck

id roboshop &>>/tmp/cart.log

if [ $? -nq 0 ]; then
  echo "adding user"
  useradd roboshop &>>/tmp/cart.log
  StatusCheck
fi
echo "downloading zip file "
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>/tmp/cart.log
StatusCheck
echo "changing direct"
cd /home/roboshop &>>/tmp/cart.log && rm -rf cart &>>/tmp/cart.log
StatusCheck
echo "unzipping"
unzip -o /tmp/cart.zip &>>/tmp/cart.log && mv cart-main cart &>>/tmp/cart.log && cd cart &>>/tmp/cart.log
StatusCheck
echo "installing node "
npm install &>>/tmp/cart.log
StatusCheck
echo "moving systemd to cart"
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service &>>/tmp/cart.log
StatusCheck
echo " running systemctl commands"
systemctl daemon-reload &>>/tmp/cart.log &&  systemctl start cart &>>/tmp/cart.log  && systemctl enable cart &>>/tmp/cart.log
StatusCheck