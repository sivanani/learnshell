script_path=${dirname $0}
source ${script_path}/common.sh
dnf install maven -y
useradd {app_user}
mkdir /app
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip 
cd /app 
unzip /tmp/shipping.zip
cd /app 
mvn clean package 
mv target/shipping-1.0.jar shipping.jar
cp ${script_path}/shipping.service /etc/systemd/system/shipping.service
systemctl daemon-reload
systemctl enable shipping 
systemctl start shipping
dnf install mysql -y
mysql -h mysql.devopsi72.online -uroot -pRoboShop@1 < /app/schema/shipping.sql
systemctl restart shipping