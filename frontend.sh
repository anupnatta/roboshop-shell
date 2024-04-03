#source common.sh

print_head "Installing Nginx"
dnf install nginx -y &>>{log_file}
status_check $?
print_head "Removing Old Content"

rm -rf /usr/share/nginx/html/* &>>{log_file}

print_head "Downloading Frontend"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>{log_file}

print_head "Extracting downloaded Content"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>{log_file}

print_head "Copying Configs"
cp ${code_dir}/configs/nginx.roboshop.config /etc/nginx/default.d/roboshop.conf &>>{log_file}


print_head "Enabling Nginx"
systemctl enable nginx &>>{log_file}

print_head "Starting Nginx"
systemctl restart nginx &>>{log_file}