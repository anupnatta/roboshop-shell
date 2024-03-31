source common.sh

print_head "Enabling nodejs"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y
dnf install nodejs -y

print_head "Roboshop UserAdd"
useradd roboshop
print_head "Creating App Directory"
mkdir /app
print_head "Removing Old Content"
rm -rf /app/*

print_head "Downloading Catalogue Artifacts"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

print_head "Unzipping catalogue.zip"
cd /app
unzip /tmp/catalogue.zip
cd /app


print_head "Downloading Node JS Dependencies"
npm install

print_head "Copying Catalogue Config files"
cp ${code_dir}/configs/catalogue.service /etc/systemd/system/catalogue.service


print_head "Reloading System D"
systemctl daemon-reload
print_head "Enabling Catalogue"
systemctl enable catalogue
print_head "Starting Catalogue"

systemctl start catalogue
print_head "Copying MongoDB Configs"
cp /configs/mongodb.repo /etc/yum.repos.d/mongo.repo
print_head "Installing Mongo Client"
dnf install mongodb-org-shell -y

print_head "Loading Schema"
mongo --host mongodb.devops69.online </app/schema/catalogue.js

