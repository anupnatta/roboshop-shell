code_dir=$(pwd)


print_head(){
  echo -e "\e[33m$1\e[0m"
}

print_head "Installing Nginx"

dnf install nginx -y

print_head "Removing Old Content"

rm -rf /usr/share/nginx/html/*

print_head "Downloading Frontend"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

print_head "Extracting downloaded Content"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

print_head "Copying Configs"
cp ${code_dir}/configs/nginx.roboshop.config /etc/nginx/default.d/roboshop.conf


print_head "Enabling Nginx"
systemctl enable nginx

print_head "Starting Nginx"
systemctl restart nginx