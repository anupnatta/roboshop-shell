source common.sh

component=cart
nodejs



#print_head "Enabling nodejs"
#dnf module disable nodejs -y &>>{log_file}
#dnf module enable nodejs:18 -y &>>{log_file}
#dnf install nodejs -y &>>{log_file}
#status_check $?
#
#print_head "Roboshop UserAdd"
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
#print_head "Downloading user Artifacts"
#curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>{log_file}
#status_check $?
#
#print_head "Unzipping cart.zip"
#cd /app
#unzip /tmp/cart.zip &>>{log_file}
#cd /app
#status_check $?
#
#print_head "Downloading Node JS Dependencies"
#npm install &>>{log_file}
#status_check $?
#
#print_head "Copying cart Config files"
#cp ${code_dir}/configs/cart.service /etc/systemd/system/cart.service &>>{log_file}
#status_check $?
#
#print_head "Reloading System D"
#systemctl daemon-reload
#status_check $?
#
#print_head "Enabling cart"
#systemctl enable cart
#status_check $?
#
#print_head "Starting cart"
#
#systemctl start cart
#status_check $?
##print_head "Copying MongoDB Configs"
##cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>{log_file}
##status_check $?
##
##print_head "Installing Mongo Client"
##dnf install mongodb-org-shell -y &>>{log_file}
##status_check $?
##
##print_head "Loading Schema"
##mongo --host mongodb.devops69.online </app/schema/cart.js
##status_check $?