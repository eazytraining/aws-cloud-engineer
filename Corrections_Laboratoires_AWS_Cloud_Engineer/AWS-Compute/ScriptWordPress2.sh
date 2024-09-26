#!/bin/bash
sudo apt update
sudo apt install apache2 \
                 ghostscript \
                 libapache2-mod-php \
                 mysql-server \
                 php \
                 php-bcmath \
                 php-curl \
                 php-imagick \
                 php-intl \
                 php-json \
                 php-mbstring \
                 php-mysql \
                 php-xml \
                 php-zip
sudo mkdir -p /srv/www
sudo chown www-data: /srv/www
curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www
sudo nano /etc/apache2/sites-available/wordpress.conf
#<VirtualHost *:80>
   # DocumentRoot /srv/www/wordpress
   # <Directory /srv/www/wordpress>
        #Options FollowSymLinks
        #AllowOverride Limit Options FileInfo
       # DirectoryIndex index.php
        #Require all granted
    #</Directory>
    #<Directory /srv/www/wordpress/wp-content>
       # Options FollowSymLinks
       # Require all granted
    #</Directory>
    #ErrorLog ${APACHE_LOG_DIR}/error.log
    #CustomLog ${APACHE_LOG_DIR}/access.log combined
#</VirtualHost>
sudo a2ensite wordpress
sudo a2enmod rewrite
sudo a2dissite 000-default
sudo service apache2 reload
sudo mysql -u root
CREATE DATABASE wordpress;
CREATE USER wordpress@localhost IDENTIFIED BY 'Wordpress123';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER
ON wordpress.*
TO wordpress@localhost;


