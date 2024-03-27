source common.sh



dnf module disable nodejs -y


dnf module enable nodejs:18 -y
dnf install nodejs -y
useradd roboshop
mkdir /app
rm -rf /app/*
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip
cd /app
npm install
cp config/catalogue.service /etc/systemd/system/catalogue.service

systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue

cp config/mongodb.repo /etc/yum.repos.d/mongo.repo

dnf install mongodb-org-shell -y

mongo --host mongodb.devops.69online </app/schema/catalogue.js
