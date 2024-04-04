source comman.sh

mysql_root_password=$1
if [ -z "${mysql_root_paswword}" ]; then
  echo -e "\e31mMissing MYSQL Password argument\e[0m"
  exit 1
fi
print_head "Disabling MYSQL"
dnf module disable mysql -y $>>{log_file}
status_check $?

print_head "Installing MYSQL Server"
dnf install mysql-community-server -y &>>{log_file}
status_check $?

print_head "Enabling MYSQL"
systemctl enable mysqld &>>{log_file}
status_check $?

print_head "Starting MYSQL"
systemctl start mysqld &>>{log_file}
status_check $?

print_head "Root Password Setup"
echo show database | mysql -uroot -p${mysql_root_password} $>>{log_file}
if [ $? -ne 0 ]; then
  mysql_secure_installation --set-root-pass ${mysql_root_password} $>>{log_file}
fi