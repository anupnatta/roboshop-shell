source common.sh

print_head "Enabling NODE JS"
dnf module disable nodejs -y &>>{log_file}
dnf module enable nodejs:18 -y &>>{log_file}
status_check $?

print_head "Install NodeJS"
dnf install nodejs -y &>>{log_file}
status_check $?

print_head "Roboshop User ADD"
if [ $? -ne 0 ]; then
  useradd roboshop $>> {log_file}
fi
status_check $?

print_head "Creating APP directory"
if [ $? -ne 0 ]; then
mkdir /app $>>{log_file}
fi
status_check $?

print_head "Downloading the App Code"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
status_check $?

print_head "Unzipping User.zip"
unzip /tmp/user.zip &>>{log_file}
status_check $?

print_head "Downloading NodeJS Dependencies"
cd /app
npm install &>>{log_file}
status_check $?

print_head "Copying User Config files"
cp ${code_dir}/configs/user.service /etc/systemd/system/user.service &>>{log_file}
status_check $?

print_head "Reloading System D"
systemctl daemon-reload
status_check $?

print_head "Enabling User"
systemctl enable user
status_check $?

print_head "Starting User"
systemctl start user
status_check $?

print_head "Copying MongoDB Configs"
cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>{log_file}
status_check $?

print_head "Installing Mongo Client"
dnf install mongodb-org-shell -y &>>{log_file}
status_check $?

print_head "Loading Schema"
mongo --host mongodb.devops69.online </app/schema/user.js
status_check $?



