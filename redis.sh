source common.sh

print_head "Installing Redis Repo Files"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>{log_file}
status_check $?

print_head "Enable Redis 6.2 from Package Streams"
dnf module enable redis:remi-6.2 -y &>>{log_file}
status_check $?

print_head "Install Redis"
dnf install redis -y &>>{log_file}
status_check $?

print_head "Updating the MongoDB Listner Address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
status_check $?

print_head "Enable Redis"
systemctl enable redis &>>{log_file}
status_check $?

print_head "Start Redis"
systemctl start redis &>>{log_file}
status_check $?
