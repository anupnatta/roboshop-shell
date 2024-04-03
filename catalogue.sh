#source common.sh

print_head "Enabling nodejs"
dnf module disable nodejs -y &>>{log_file}
dnf module enable nodejs:18 -y &>>{log_file}
dnf install nodejs -y &>>{log_file}
status_check $?

print_head "Roboshop UserAdd"
useradd roboshop
status_check $?

print_head "Creating App Directory"
mkdir /app
status_check $?

print_head "Removing Old Content"
rm -rf /app/*
status_check $?

print_head "Downloading Catalogue Artifacts"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>{log_file}
status_check $?

print_head "Unzipping catalogue.zip"
cd /app
unzip /tmp/catalogue.zip &>>{log_file}
cd /app
status_check $?

print_head "Downloading Node JS Dependencies"
npm install &>>{log_file}
status_check $?

print_head "Copying Catalogue Config files"
cp ${code_dir}/configs/catalogue.service /etc/systemd/system/catalogue.service &>>{log_file}
status_check $?

print_head "Reloading System D"
systemctl daemon-reload
status_check $?

print_head "Enabling Catalogue"
systemctl enable catalogue
status_check $?

print_head "Starting Catalogue"
systemctl start catalogue
status_check $?

print_head "Copying MongoDB Configs"
cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>{log_file}
status_check $?

print_head "Installing Mongo Client"
dnf install mongodb-org-shell -y &>>{log_file}
status_check $?

print_head "Loading Schema"
mongo --host mongodb.devops69.online </app/schema/catalogue.js $>>{log_file}
status_check $?
