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

#TOMCAT INSTALLATION
# sudo apt update -y
# sudo apt-get install openjdk-11-jre -y
# sudo curl -O https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.74/bin/apache-tomcat-9.0.74.tar.gz
# sudo tar -xzvf apache-tomcat-9.0.74.tar.gz -C /opt
# sudo curl -O https://s3-us-west-2.amazonaws.com/studentapi-cit/student.war
# sudo curl -O https://s3-us-west-2.amazonaws.com/studentapi-cit/mysql-connector.jar
# sudo mv mysql-connector.jar /opt/apache-tomcat-9.0.74/lib
# sudo mv student.war /opt/apache-tomcat-9.0.74/webapps
# cd /opt/apache-tomcat-9.0.74/bin/
# sudo ./catalina.sh start

#JENKINS INSTALLATION
# curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
# echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
# sudo apt-get update 
# sudo apt-get install fontconfig openjdk-11-jre -y
# sudo apt-get install jenkins -y