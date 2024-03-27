source common.sh

print_head "Copying MongoDB config files and setting up MongoDB repo"

cp configs/mongodb.repo /etc/yum.repos.d/mongo.repo

print_head "Installing MongoDB"
dnf install mongodb-org -y

print_head "Enable MongoDB"
systemctl enable mongod

print_head "Start MongoDB"
systemctl start mongod

# Update listen address from 127.0.0.1 to 0.0.0.0


