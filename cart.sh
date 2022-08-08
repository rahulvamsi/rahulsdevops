#set -e
source Common.sh

NodeJS

echo "unzipping"
unzip -o /tmp/cart.zip
StatusCheck
echo " moving and changing"
mv cart-main cart &>>/tmp/cart.log && cd cart &>>/tmp/cart.log
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