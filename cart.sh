#set -e

echo "downloading repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/cart.log
echo  $?
if [ $? -eq 0 ];
then
  echo  " sucess"
else
  echo "failed"
fi
echo "installing node"
yum install nodejs -y &>>/tmp/cart.log
echo  $?
echo "addind user"
useradd roboshop &>>/tmp/cart.log
echo  $?
echo "downloading zip file "
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>/tmp/cart.log
echo  $?
echo "changing direct"
cd /home/roboshop &>>/tmp/cart.log
echo  $?
echo " removing cart user"
rm -rf cart &>>/tmp/cart.log
echo  $?
echo "unzipping"
unzip -o /tmp/cart.zip &>>/tmp/cart.log
echo  $?
echo "moving"
mv cart-main cart &>>/tmp/cart.log
echo  $?
echo "changing dir"
cd cart &>>/tmp/cart.log
echo  $?
echo "installing node "
npm install &>>/tmp/cart.log
echo  $?
echo "moving systemd to cart"
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service &>>/tmp/cart.log
echo  $?
echo " running systemctl commands"
systemctl daemon-reload &>>/tmp/cart.log
systemctl start cart &>>/tmp/cart.log
systemctl enable cart &>>/tmp/cart.log
echo  $?