#!/bin/sh
######## START OF WEBSERVER INSTALL##################
echo We are now going to install a Webserver on Ubutnu 20.04 With
echo Apache2, php7.4, MySQL, PhpMyAdmin, Lets Encrypt
echo Waiting 10 Seconds Press Ctr + c to cancel
sleep 10

# update ubuntu 20.04
apt update
apt -y upgrade

# Add additional repositories
add-apt-repository ppa:ondrej/php
add-apt-repository ppa:ondrej/apache2
apt -y update

# Install software
apt -y install software-properties-common
apt -y install apache2
apt -y install php7.4
apt install php7.4-common php7.4-mysql php7.4-curl php7.4-json php7.4-zip php7.4-cgi php7.4-opcache php7.4-mbstring php7.4-xml php7.4-bcmath php7.4-mysqli php7.4-gd  
apt -y install net-tools

# Setup the website config file
rm /etc/apache2/sites-available/000-default.conf
cp 000-default.conf /etc/apache2/sites-available/

# Activate the sites config
a2ensite 000-default.conf
apache2ctl configtest
a2enmod headers
a2enmod rewrite
a2enmod ssl
######## END  OF WEBSERVER INSTALL##################


######## START OF SSL INSTALL##################
# install ssl on the server
apt -y update
apt -y upgrade
apt -y install certbot python3-certbot-apache
systemctl reload apache2
certbot --apache
######## END OF SSL INSTALL##################

######## START OF MYSQL  INSTALL##################
apt -y update
apt -y install mysql-server

### SECURE MYSQL INSTALL ###
mysql_secure_installation
######## END OF MYSQL INSTALL##################

######## START OF PHPMYADMIN INSTALL##################
sudo -y apt install phpmyadmin
sudo a2enconf phpmyadmin.conf
######## END OF PHPMYADMIN INSTALL##################



# restart apache2
systemctl restart apache2

# remove default index file
rm /var/www/html/index.html
cp index.html /var/www/html/

# Final message
echo Your webserver is now installed with Apache and php7.4

# Output server info here
cat /etc/apache2/sites-available/000-default.conf
# Exit the script
exit 0



#!/bin/bash
# Description: Set up MySQL Community Release 5.7

# Get the repo RPM and install it.
wget http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm 
yum -y install ./mysql57-community-release-el7-7.noarch.rpm 

# Install the server and start it
yum -y install mysql-community-server 
systemctl start mysqld 

# Get the temporary password
temp_password=$(grep password /var/log/mysqld.log | awk '{print $NF}')

# Set up a batch file with the SQL commands
echo "CREATE USER 'root'@'localhost' IDENTIFIED BY 'Newhakase-labs123@'; flush privileges;" > reset_pass.sql

# Log in to the server with the temporary password, and pass the SQL file to it.
mysql -u root --password="$temp_password" --connect-expired-password < reset_pass.sql
