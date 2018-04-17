#!/bin/bash

#Set up necessary services
apt-get -y update
apt-get -y install ssh
apt-get -y install git
apt-get -y install apache2 apache2-doc apache2-utils
apt-get install -y php

#Setting ssh and git
#Adding Git user configs
git config --global user.name “admin”
git config --global user.email "admin@admin.com"
git config --global core.editor vim

#Adding Git user and set any passwords to empiredidnothingwrong
adduser admin --gecos "" --disabled-password
echo "empiredidnothingwrong" | passwd admin

#Creating Git admin directory
mkdir /home/admin/admin && cd /home/admin/admin
git init --bare
chown -R admin:admin /home/admin
echo "AllowUsers admin" >> /etc/ssh/sshd_config
service ssh restart

#Start Apache
Service apache2 start

#Enable SSL and PHP modules within Apache configuration
a2enmod ssl
a2enmod php7.0

#Create SSL key
openssl req -newkey -x509 -sha1 -newkey rsa:1024 -nodes -keyout securesl.key -out securesl.crt -subj '/O=Company/OU=Department/CN=localhost'
mv ./securesl.crt /var/www/securesl.crt
mv ./securesl.key /var/www/securesl.key

#Apache configuration for port 80 and 443
Apacheconfigs="<VirtualHost *:80>
	Redirect permanent / https://127.0.0.1
	ErrorLog ${APACHE_LOG_DIR}/error.log
</VirtualHost>
<VirtualHost *:443>
	DocumentRoot /var/www/html
	SSLEngine on
	SSLCertificateFile /var/www/securesl.crt
	SSLCertificateKeyFile /var/www/securesl.key
	ErrorLog ${APACHE_LOG_DIR}/error.log
</VirtualHost>"

#Modify Apache configuration
echo "$Apacheconfigs" > /etc/apache2/sites-available/000-default.conf
rm -f /var/www/html/index.html

#Necessary for shell_exec to run
echo "safe_mode = Off" >> /etc/php/7.0/apache2/php.ini

#Must restart Apache so that configs are reloaded with what we changed
service apache2 restart

# Updating shell to bash
sed -i s#/home/admin:/bin/false#/home/admin:/bin/bash# /etc/passwd
