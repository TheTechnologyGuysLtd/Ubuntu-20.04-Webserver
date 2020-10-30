Setup a Webserver on Ubuntu 20.04 This ./install.sh file will install Apache2 Php7.4 MySql & PhpMyAdmin onto a Ubuntu 20.04 server
This install script is for setting up a server to run the Script MULY found here: https://codecanyon.net/item/muly-short-video-sharing-app/28759318

This will set up a full web server that can run the Muly Script this install.sh file will not install the muly code onto the server

Tested and works fine with
Vultr
DigitalOcean
Ovh
Connect to your server over SSH and run the below command

MUST BE RUN UNDER ROOT
only on OVH ubuntu 20.04 run this command first:
sudo -i
wget https://raw.githubusercontent.com/TheTechnologyGuysLtd/Ubuntu-20.04-Webserver/main/install.sh
sudo chmod +x install.sh
sudo ./install.sh

Then follow the on-screen commands to set up the server
What Will Be Installed
apache2
php7.4
mysql
PHPMyAdmin
free Let's Encrypt SSL

PHP extensions that will be installed
php7.4-common
php7.4-mysql
php7.4-curl
php7.4-json
php7.4-zip
php7.4-cgi
php7.4-opcache
php7.4-mbstring
php7.4-xml
php7.4-bcmath
php7.4-mysqli
php7.4-gd

The let's encrypt will ask you a few questions fill then in to get a free SSL for your domain
