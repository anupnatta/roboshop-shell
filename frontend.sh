echo -e "\e[36mInstalling Nginx \e[0m"
dnf install nginx -y

echo -e "\e[36mRemoving Old Content \e[0m"

rm -rf /usr/share/nginx/html/*

echo -e "\e[36mDownloading Frontend \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[36mExtracting downloaded Content \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[36mCopying Configs \e[0m"
cp /configs/nginx.roboshop.config /etc/nginx/default.d/roboshop.conf


echo -e "\e[36mEnabling Nginx \e[0m"
systemctl enable nginx

echo -e "\e[36mStarting Nginx \e[0m"
systemctl restart nginx