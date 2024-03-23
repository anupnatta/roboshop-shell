code_dir=${pwd}

echo -e "\e[32mInstalling Nginx \e[0m"

dnf install nginx -y

echo -e "\e[32mRemoving Old Content \e[0m"

rm -rf /usr/share/nginx/html/*

echo -e "\e[32mDownloading Frontend \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[32mExtracting downloaded Content \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[32mCopying Configs \e[0m"
cp {code_dir}/configs/nginx.roboshop.config /etc/nginx/default.d/roboshop.conf


echo -e "\e[32mEnabling Nginx \e[0m"
systemctl enable nginx

echo -e "\e[32mStarting Nginx \e[0m"
systemctl restart nginx