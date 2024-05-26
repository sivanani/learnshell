script_path=${dirname $0}
source ${script_path}/common.sh
dnf module disable nodejs -y
dnf module enable nodejs:18 -y
dnf install nodejs -y
useradd roboshop
mkdir /app 
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip 
cd /app 
unzip /tmp/cart.zip
cd /app 
npm install
cp ${script_path}/cart.service /etc/systemd/system/cart.service
systemctl daemon-reload
systemctl enable cart 
systemctl start cart