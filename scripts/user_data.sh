#!/bin/bash

apt update -y
apt install apache2 unzip wget php php-mysql php-curl php-gd php-intl php-xml php-mbstring -y

cd /var/www/html

rm index.html

wget https://download.prestashop.com/download/releases/prestashop_8.1.5.zip
unzip prestashop_8.1.5.zip
unzip prestashop.zip

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

systemctl restart apache2