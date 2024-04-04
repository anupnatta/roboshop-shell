source common.sh

component=catalogue
schema_type=mongo
nodejs

#print_head "Enabling nodejs"
#dnf module disable nodejs -y &>>{log_file}
#dnf module enable nodejs:18 -y &>>{log_file}
#dnf install nodejs -y &>>{log_file}
#status_check $?
#
#print_head "Roboshop User Add"
#id roboshop &>>{log_file}
#if [ $? -ne 0 ]; then
#  useradd roboshop &>>{log_file}
#fi
#status_check $?
#
#print_head "Creating App Directory"
#if [ ! -d /app ]; then
#  mkdir /app &>>{log_file}
#fi
#status_check $?
#
#print_head "Removing Old Content"
#rm -rf /app/*
#status_check $?
#
#print_head "Downloading catalogue Artifacts"
#curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>{log_file}
#status_check $?
#
#print_head "Unzipping catalogue.zip"
#cd /app
#unzip /tmp/catalogue.zip &>>{log_file}
#cd /app
#status_check $?
#
#print_head "Downloading Node JS Dependencies"
#npm install &>>{log_file}
#status_check $?
#
#print_head "Copying catalogue Config files"
#cp ${code_dir}/configs/catalogue.service /etc/systemd/system/catalogue.service &>>{log_file}
#status_check $?
#
#print_head "Reloading System D"
#systemctl daemon-reload
#status_check $?
#
#print_head "Enabling catalogue"
#systemctl enable catalogue
#status_check $?
#
#print_head "Starting catalogue"
#systemctl start catalogue
#status_check $?
#
#print_head "Copying MongoDB Configs"
#cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>{log_file}
#status_check $?
#
#print_head "Installing Mongo Client"
#dnf install mongodb-org-shell -y &>>{log_file}
#status_check $?
#
#print_head "Loading Schema"
#mongo --host mongodb.devops69.online </app/schema/catalogue.js
#status_check $?