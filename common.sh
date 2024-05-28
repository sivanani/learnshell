app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")

schema_setup(){
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org-shell -y
echo -e "\e[36m >>>>>>> mongodb connection <<<<<<<\e[0m"
mongo --host mongodb.devopsi72.online </app/schema/${component}.js
}


func_nodejs(){
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
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 
echo -e "\e[36m >>>>>>> Install catalogue content <<<<<<<\e[0m"
cd /app 
unzip /tmp/${component}.zip
cd /app 
npm install
cp ${script_path}/${component}.service /etc/systemd/system/${component}.service
echo -e "\e[36m >>>>>>> Restart catalogue server <<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable ${component} 
systemctl start ${component}

}