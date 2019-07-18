#!/bin/bash

# Following tutorial from https://www.linuxbabe.com/ubuntu/install-lamp-stack-ubuntu-18-04-server-desktop

# Install packages
sudo apt install -y apache2 apache2-utils
sudo apt install -y mariadb-server mariadb-client
sudo apt install -y php7.2 libapache2-mod-php7.2 php7.2-mysql php7.2-cli php7.2-common php7.2-json php7.2-opcache php7.2-readline php7.2-mbstring


# Run if for some reason is not started automatically
sudo systemctl start apache2
sudo systemctl start mariadb


# Set to start automatically on each system boot
sudo systemctl enable apache2
sudo systemctl enable mariadb


# Configure MySQL (perform `mysql_secure_installation`)

# Set `root` as password for `root` user
sudo mysql -e "UPDATE mysql.user SET Password = PASSWORD('root') WHERE User = 'root'"

# Delete the anonymous users
sudo mysql -e "DELETE FROM mysql.user WHERE User='';"

# Ensure the root user can not log in remotely
sudo mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"

# Drop off the demo database
sudo mysql -e "DROP DATABASE IF EXISTS test"
sudo mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'";

# Change default plugin to `mysql_native_password` so we can login with root user with vagrant or any other user
sudo mysql -e "UPDATE mysql.user SET plugin='mysql_native_password' WHERE User='root';"

# Make our changes take effect
sudo mysql -e "FLUSH PRIVILEGES"

sudo systemctl restart mariadb