set -e
yum install maven -y >>/tmp/shipping.log
userdel -r -f roboshop  >>/tmp/shipping.log
useradd roboshop >>/tmp/shipping.log
cd /home/roboshop >>/tmp/shipping.log
rm -rf shipping
curl -s -L -o /tmp/shipping.zip "https://github.com/roboshop-devops-project/shipping/archive/main.zip">>/tmp/shipping.log
unzip -o /tmp/shipping.zip >>/tmp/shipping.log
mv shipping-main shipping
cd shipping
mvn clean package
mv target/shipping-1.0.jar shipping.jar
mv /home/roboshop/shipping/systemd.service /etc/systemd/system/shipping.service
systemctl daemon-reload
systemctl start shipping
systemctl enable shipping