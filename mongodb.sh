cp mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org -y 
systemctl enable mongod
systemctl restart mongod

#127.0.0.1 to 0.0.0.0 in /etc/mongod.conf