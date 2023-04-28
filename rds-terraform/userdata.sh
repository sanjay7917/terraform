#!/bin/bash
#NGINX INSTALLATION
# sudo apt-get install nginx -y
# sudo systemctl start nginx 
# sudo systemctl enable nginx
# echo "Machine IP: $HOSTNAME" > /var/www/html/index.nginx-debian.html

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

#RDS CONFIG
# sudo apt-get install mysql* -y
# sudo systemctl start mysql 
# sudo systemctl enable mysql
# sudo systemctl status mysql (DO NOT DO THIS)
# mysql -h terraform-20230427114740068200000001.cmomitk2ez52.us-east-2.rds.amazonaws.com -u admin -ppassword < sqlscript.sql
# CREATE DATABASE studentapp;
# show databases;
# use studentapp;
# CREATE TABLE if not exists students(student_id INT NOT NULL AUTO_INCREMENT,
# student_name VARCHAR(100) NOT NULL,
# student_addr VARCHAR(100) NOT NULL,
# student_age VARCHAR(3) NOT NULL,
# student_qual VARCHAR(20) NOT NULL,
# student_percent VARCHAR(10) NOT NULL,
# student_year_passed VARCHAR(10) NOT NULL,
# PRIMARY KEY (student_id)
# );
# aws secretsmanager get-secret-value  --secret-id kisikopatanachale --region=us-east-2 | jq -r .SecretString | jq -r .password
# aws secretsmanager get-secret-value  --secret-id kisikopatanachale --region=us-east-2 --query SecretString --output text (FOR SECRET MANAGER KEY AND VALUE IN JSON FORMAT)
# aws secretsmanager get-secret-value --secret-id kisikopatanachale --query 'SecretString' --output text | jq -r 'to_entries[] | "\(.key)=\(.value)"' (FOR SECRET MANAGER KEY AND VALUE)
# aws secretsmanager get-secret-value --secret-id kisikopatanachale --query 'SecretString' --output text | jq -r 'to_entries[] | "\(.value)"' (FOR SECRET MANAGER VALUE)