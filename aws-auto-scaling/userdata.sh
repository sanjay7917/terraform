#!/bin/bash
#NGINX INSTALLATION
sudo apt-get install nginx -y
sudo systemctl start nginx 
sudo systemctl enable nginx
echo "Machine IP: $HOSTNAME" > /var/www/html/index.nginx-debian.html
