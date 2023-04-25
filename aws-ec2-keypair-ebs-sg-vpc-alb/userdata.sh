#!/bin/bash
#APACHE INSTALLATION
# sudo apt-get update -y 
# sudo apt-get install apache2 -y
# sudo systemctl start apache2 
# sudo systemctl enable apache2
# echo "Hello From APACHE" > /var/www/html/index.html

#NGINX INSTALLATION
sudo apt-get install nginx -y
sudo systemctl start nginx 
sudo systemctl enable nginx
echo "Machine IP: $HOSTNAME" > /var/www/html/index.nginx-debian.html

#JENKINS INSTALLATION
# curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
# echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
# sudo apt-get update 
# sudo apt-get install fontconfig openjdk-11-jre -y
# sudo apt-get install jenkins -y