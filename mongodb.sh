source common.sh

print_head "Copying MongoDB config files and setting up MongoDB repo"

cp ${code_dir}configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>{log_file}

print_head "Installing MongoDB"
dnf install mongodb-org -y &>>{log_file}

print_head "Updating Mondgo DB Listner Address"
sed -i -e 's/127.0.0.1/0.0.0.0' /etc/mongod.conf

print_head "Enable MongoDB"
systemctl enable mongod

print_head "Start MongoDB"
systemctl start mongod

# Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf


