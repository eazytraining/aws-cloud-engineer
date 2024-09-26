#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
sudo apt-get install mysql-server -y
sudo systemctl start mysql
sudo systemctl enable mysql
sudo mysql_secure_installation <<EOF
y
0
y
y
y
y
EOF
DB_NAME="Demo"
DB_USER="Lab"
DB_PASSWORD="Lab123"
sudo mysql -u root <<EOF
CREATE DATABASE ${DB_NAME};
CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EXIT;
EOF
sudo apt-get install php libapache2-mod-php php-mysql php-mbstring php-zip php-gd php-json php-curl -y
sudo apt-get install phpmyadmin -y
sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
sudo phpenmod mbstring
sudo systemctl restart apache2
sudo sed -i "s/bind-address\s*=.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
echo "Installation terminée. Accédez à phpMyAdmin via : http://${PUBLIC_IP}/phpmyadmin"

