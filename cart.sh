#set -e

echo "downloading repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/cart.log
if [ $? -eq 0 ];
then
  echo  " sucess"
elif [ $? -nq 0 ]; then


  echo "failed"
fi
echo "installing node"
yum install nodejs -y &>>/tmp/cart.log
if [ $? -eq 0 ];
then
  echo  " sucess"
else
  echo "failed"
fi
id roboshop &>>/tmp/cart.log
if [$? -eq 0 ]; then
  echo " user exists already"
else
  echo "adding user"
  useradd roboshop &>>/tmp/cart.log
fi
if [ $? -eq 0 ];
then
  echo  " sucess"
else
  echo "failed"
fi
echo "downloading zip file "
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>/tmp/cart.log
if [ $? -eq 0 ];
then
  echo  " sucess"
else
  echo "failed"
fi
echo "changing direct"
cd /home/roboshop &>>/tmp/cart.log
if [ $? -eq 0 ];
then
  echo  " sucess"
else
  echo "failed"
fi
echo " removing cart user"
rm -rf cart &>>/tmp/cart.log
if [ $? -eq 0 ];
then
  echo  " sucess"
else
  echo "failed"
fi
echo "unzipping"
unzip -o /tmp/cart.zip &>>/tmp/cart.log
if [ $? -eq 0 ];
then
  echo  " sucess"
else
  echo "failed"
fi
echo "moving"
mv cart-main cart &>>/tmp/cart.log
if [ $? -eq 0 ];
then
  echo  " sucess"
else
  echo "failed"
fi
echo "changing dir"
cd cart &>>/tmp/cart.log
if [ $? -eq 0 ];
then
  echo  " sucess"
else
  echo "failed"
fi
echo "installing node "
npm install &>>/tmp/cart.log
if [ $? -eq 0 ];
then
  echo  " sucess"
else
  echo "failed"
fi
echo "moving systemd to cart"
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service &>>/tmp/cart.log
if [ $? -eq 0 ];
then
  echo  " sucess"
else
  echo "failed"
fi
echo " running systemctl commands"
systemctl daemon-reload &>>/tmp/cart.log
systemctl start cart &>>/tmp/cart.log
systemctl enable cart &>>/tmp/cart.log
if [ $? -eq 0 ];
then
  echo  " sucess"
else
  echo "failed"
fi