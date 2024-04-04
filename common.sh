code_dir=$(pwd)
log_file=/tmp/roboshop.log
rm -f {log_file}

print_head() {
  echo -e "\e[34m$1\e[0m"
}

status_check() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILED\e[0m"
  fi
}
NODEJS(){

print_head "Enabling nodejs"
dnf module disable nodejs -y &>>{log_file}

dnf module enable nodejs:18 -y &>>{log_file}
dnf install nodejs -y &>>{log_file}
status_check $?

print_head "Roboshop UserAdd"
id roboshop &>>{log_file}
if [ $? -ne 0 ]; then
useradd roboshop &>>{log_file}
fi
status_check $?

print_head "Creating App Directory"
if [ ! -d /app ]; then
mkdir /app &>>{log_file}
fi
status_check $?

print_head "Removing Old Content"
rm -rf /app/*
status_check $?

print_head "Downloading ${component} Artifacts"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>{log_file}
status_check $?

print_head "Unzipping ${component}.zip"
cd /app
unzip /tmp/${component}.zip &>>{log_file}
cd /app
status_check $?

print_head "Downloading Node JS Dependencies"
npm install &>>{log_file}
status_check $?

print_head "Copying ${component} Config files"
cp ${code_dir}/configs/${component}.service /etc/systemd/system/${component}.service &>>{log_file}
status_check $?

print_head "Reloading System D"
systemctl daemon-reload
status_check $?

print_head "Enabling ${component}"
systemctl enable ${component}
status_check $?

print_head "Starting ${component}"
systemctl start ${component}
status_check $?

print_head "Copying MongoDB Configs"
cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>{log_file}
status_check $?

print_head "Installing Mongo Client"
dnf install mongodb-org-shell -y &>>{log_file}

status_check $?

print_head "Loading Schema"
mongo --host mongodb.devops69.online </app/schema/${component}.js
status_check $?
}
