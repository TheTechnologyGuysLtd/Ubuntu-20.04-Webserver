#!/bin/sh
######## START OF WEBSERVER INSTALL##################
echo "
This file will install a full web server on ubuntu 20.04
Author: The Technology Guys Ltd
Website: https://thetechguys.site
Email: support@thetechguys.site     
"
sleep 5

read -p "Please Enter your website domain exsample.com:" ServerName
read -p "Please Enter your website domain alias www.exsample.com:" ServerAlias
read -p "Please Enter your ServerAdmin email webmaster@exsample.com:"  ServerAdmin
read -p "Please Enter Database Name:" dbname
read -p "Please enter the username you wish to create : " username
read -p "Please Enter the Password for the user ($username) : " password


echo "
    Author: The Technology Guys Ltd
    Website: https://thetechguys.site
    Email: support@thetechguys.site

    This file has all you saved information that you set up during the installation
    Please make a note of the information in this file and remove the file from your server for security reasons
    The file is located at cd /var/www/

    Domain info:
    ServerName $ServerName
    ServerAlias $ServerAlias

    MySQL info:
    Database name: $dbname
    Username: $username
    Password: $password
    host: localhost
    
    Website Root: /var/www/html/ 
    https://$ServerName/phpmyadmin


Your ubuntu 20.04 web server is now installed 
What was installed
Apache2, php7.4, MySQL, PhpMyAdmin, Lets Encrypt

What PHP Extensions whre installed                                      
php7.4-common php7.4-mysql php7.4-curl php7.4-json php7.4-zip php7.4-cgi php7.4-opcache php7.4-mbstring php7.4-xml php7.4-bcmath php7.4-mysqli php7.4-gd 
" > info.txt

# update ubuntu 20.04
apt update
apt -y upgrade

# Add additional repositories
echo "ENTER" | add-apt-repository ppa:ondrej/php
echo "ENTER" | add-apt-repository ppa:ondrej/apache2
apt -y update

# Install software
apt -y install software-properties-common
apt -y install apache2
apt -y install php7.4
apt -y install php7.4-common php7.4-mysql php7.4-curl php7.4-json php7.4-zip php7.4-cgi php7.4-opcache php7.4-mbstring php7.4-xml php7.4-bcmath php7.4-mysqli php7.4-gd
#apt -y install net-tools

# Setup the website config file
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.old
rm /etc/apache2/sites-available/000-default.conf

echo "<VirtualHost *:80>
    ServerAdmin $ServerAdmin
    ServerName $ServerName
    ServerAlias $ServerAlias
    DocumentRoot /var/www/html/public
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
<Directory /var/www/html/public>
    Options Indexes FollowSymLinks MultiViews
    AllowOverride All
    Order allow,deny
    allow from all
 </Directory>
</VirtualHost>" > /etc/apache2/sites-available/000-default.conf

# Activate the sites config
a2ensite 000-default.conf
apache2ctl configtest
a2enmod headers
a2enmod rewrite
a2enmod ssl
######## END  OF WEBSERVER INSTALL##################

######## START OF MYSQL  INSTALL##################
apt -y update
apt -y install mysql-server
mysql -e "CREATE USER '$username'@'%' IDENTIFIED BY '$password'";
mysql -e "CREATE DATABASE $dbname";
mysql -e "GRANT ALL PRIVILEGES ON $dbname.* TO '$username'@'%'";

### SECURE MYSQL INSTALL ###
# mysql_secure_installation
######## END OF MYSQL INSTALL##################

######## START OF PHPMYADMIN INSTALL##################
sudo apt -y install phpmyadmin
######## END OF PHPMYADMIN INSTALL##################

######## SETUP FIREWALL ###############
sudo apt -y install ufw
ufw allow http
ufw allow https
ufw allow ssh
ufw allow mysql
echo "y" | sudo ufw enable
######## SETUP FIREWALL ###############

######## START OF SSL INSTALL##################
# install ssl on the server
apt -y update
apt -y upgrade
apt -y install certbot python3-certbot-apache
certbot --apache --agree-tos --redirect
######## END OF SSL INSTALL##################

##### Remove default index file and copying website ######
# rm /var/www/html/index.html
# sudo apt -y install zip unzip
# read -p "your website download link example.com/example.zip:"  download
# wget $download
# read -p "zip name example.zip:"  zip
# unzip $zip -d /var/www/html
# chown -R www-data:www-data storage
# chown -R www-data:www-data bootstrap
##### emove default index file and copying website ######

# restart apache2
systemctl restart apache2
systemctl restart mysql

# Final message
cat /var/www/info.txt 

# Exit the script
exit 0
