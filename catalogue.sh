echo -e "\e[36m >>>>>>> disable node module <<<<<<<\e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y
echo -e "\e[36m >>>>>>> Install node module <<<<<<<\e[0m"
dnf install nodejs -y
echo -e "\e[36m >>>>>>> Add application user <<<<<<<\e[0m"
useradd roboshop
echo -e "\e[36m >>>>>>> Remove and add directory <<<<<<<\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[36m >>>>>>> Download catalogue content <<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip 
cd /app 
unzip /tmp/catalogue.zip
echo -e "\e[36m >>>>>>> Install catalogue content <<<<<<<\e[0m"
cd /app
npm install
cp /home/centos/learnshell/catalogue.service /etc/systemd/system/catalogue.service
echo -e "\e[36m >>>>>>> Restart catalogue server <<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable catalogue 
systemctl restart catalogue
echo -e "\e[36m >>>>>>> copy mongorepo file <<<<<<<\e[0m"
cp /home/centos/learnshell/mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org-shell -y
echo -e "\e[36m >>>>>>> mongodb connection <<<<<<<\e[0m"
mongo --host mongodb.devopsi72.online </app/schema/catalogue.js