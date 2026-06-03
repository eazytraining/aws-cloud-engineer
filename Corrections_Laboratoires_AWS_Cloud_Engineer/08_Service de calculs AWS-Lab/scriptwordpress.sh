#!/bin/bash

RDS_ENDPOINT="wordpress.cqtagkcuuqab.us-east-1.rds.amazonaws.com"  
RDS_PORT="3306"
DB_NAME="wordpress"
DB_USER="wordpress"
DB_PASSWORD="Wordpress123!"           
DB_PREFIX="wp_"
WP_DOMAIN="100.55.8.141"              

sudo apt update && sudo apt upgrade -y
sudo apt install -y \
    apache2 \
    ghostscript \
    libapache2-mod-php \
    php \
    php-bcmath \
    php-curl \
    php-imagick \
    php-intl \
    php-json \
    php-mbstring \
    php-mysql \
    php-xml \
    php-zip \
    php-cli \
    unzip \
    curl

sudo mkdir -p /srv/www
sudo chown www-data: /srv/www
curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www

sudo tee /etc/apache2/sites-available/wordpress.conf > /dev/null <<EOF
<VirtualHost *:80>
    ServerName ${WP_DOMAIN}
    DocumentRoot /srv/www/wordpress

    <Directory /srv/www/wordpress>
        Options FollowSymLinks
        AllowOverride Limit Options FileInfo
        DirectoryIndex index.php
        Require all granted
    </Directory>

    <Directory /srv/www/wordpress/wp-content>
        Options FollowSymLinks
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/wordpress-error.log
    CustomLog \${APACHE_LOG_DIR}/wordpress-access.log combined
</VirtualHost>
EOF

sudo a2ensite wordpress
sudo a2enmod rewrite
sudo a2dissite 000-default
sudo systemctl reload apache2
sudo -u www-data cp /srv/www/wordpress/wp-config-sample.php \
                    /srv/www/wordpress/wp-config.php

sudo -u www-data sed -i "s/database_name_here/${DB_NAME}/"     /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i "s/username_here/${DB_USER}/"          /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i "s/password_here/${DB_PASSWORD}/"      /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i "s/localhost/${RDS_ENDPOINT}/"         /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i "s/'wp_'/'${DB_PREFIX}'/"              /srv/www/wordpress/wp-config.php

sudo -u www-data sed -i "/DB_HOST/a define( 'DB_PORT', '${RDS_PORT}' );" \
    /srv/www/wordpress/wp-config.php

WP_KEYS=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)

sudo -u www-data php -r "
\$config = file_get_contents('/srv/www/wordpress/wp-config.php');
\$config = preg_replace(
    '/\/\*\*#@\+\*\/.*\/\*\*#@-\*\//s',
    trim('$WP_KEYS'),
    \$config
);
file_put_contents('/srv/www/wordpress/wp-config.php', \$config);
"

echo ""
echo "?  EC2 configuré. WordPress pointe sur RDS : ${RDS_ENDPOINT}"
echo "    Ouvrez http://${WP_DOMAIN} pour finaliser l'installation WordPress."
echo ""