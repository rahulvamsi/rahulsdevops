set -e
yum install maven -y >>/tmp/shipping.log
userdel -r -f roboshop  >>/tmp/shipping.log
useradd roboshop >>/tmp/shipping.log
cd /home/roboshop >>/tmp/shipping.log
rm -rf shipping
curl -s -L -o /tmp/shipping.zip "https://github.com/roboshop-devops-project/shipping/archive/main.zip">>/tmp/shipping.log
unzip -o /tmp/shipping.zip >>/tmp/shipping.log
mv shipping-main shipping >>/tmp/shipping.log
cd shipping >>/tmp/shipping.log
echo clening package
mvn clean package >>/tmp/shipping.log
echo moving
mv target/shipping-1.0.jar shipping.jar >>/tmp/shipping.log
mv /home/roboshop/shipping/systemd.service /etc/systemd/system/shipping.service >>/tmp/shipping.log
echo running
systemctl daemon-reload
systemctl start shipping
systemctl enable shipping