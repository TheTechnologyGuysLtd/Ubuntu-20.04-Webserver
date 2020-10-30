# Webserver
Setup a Webserver on Ubuntu 20.04
This ./install.sh file will install Apache2 Php7.4 MySql & PhpMyAdmin onto a Ubuntu 20.04 server

This install script is for setting up a server to run the Script MULY found here: https://codecanyon.net/item/muly-short-video-sharing-app/28759318

This will setup a full webserver that can run the Muly Script this install.sh file will not install the muly code onto the server

Tested and works fine with
Vultr
DigitalOcean
Ovh 




Connect to your server over SSH and run the below command<br><br>
MUST BE RUN UNDER ROOT<br>

only on OVH ubuntu 20.04 run this command first: 
sudo -i

wget https://raw.githubusercontent.com/TheTechnologyGuysLtd/Ubuntu-20.04-Webserver/main/install.sh<br>
sudo chmod +x install.sh<br>
sudo ./install.sh<br>

Then folow the on screen commands to setup the server

<b>What Will Install</b><br>
apache2<br>
php7.4<br>
mysql<br>
phpmyadmin<br><br>
<b>php exstentions that will be installed</b><br>
php7.4-common <br>
php7.4-mysql <br>
php7.4-curl <br>
php7.4-json <br>
php7.4-zip <br>
php7.4-cgi <br>
php7.4-opcache <br>
php7.4-mbstring <br>
php7.4-xml <br>
php7.4-bcmath <br>
php7.4-mysqli <br>
php7.4-gd  <br>

The Lets encrypt will ask you a few qestions fill then in to get a free SSl for your domain
