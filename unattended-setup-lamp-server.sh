#!/bin/sh

OS_NAME=$(. /etc/os-release; printf '%s\n' "$ID")
OS_CODENAME=$(. /etc/os-release; printf '%s\n' "$VERSION_CODENAME")
MYSQL_PACKAGE=mysql-8.4-lts
MYSQL_ROOT_PASSWORD=rootROOT123!
CREATE_PHPINFO_FILE=true
PHPMYADMIN_WEB_FOLDERNAME=phpmyadmin

# update system
apt-get update && apt-get upgrade -y

# install linux-tools
apt-get install -y sudo vim net-tools htop wget curl gnupg lsb-release

## install apache-webserver
apt-get install -y apache2

## install mysql-database-server

# add mysql repo to sources
echo "deb http://repo.mysql.com/apt/${OS_NAME}/ ${OS_CODENAME} ${MYSQL_PACKAGE}" > /etc/apt/sources.list.d/mysql.list

# get public key
PUBKEY=$(apt-get update 2>&1 | sed -En 's/.*(NO_PUBKEY|Missing key) ([[:xdigit:]]+).*/\2/p' | head -1) \
&& gpg --keyserver keyserver.ubuntu.com --recv-keys ${PUBKEY} \
&& gpg --armor --export ${PUBKEY} | gpg --dearmor -o /etc/apt/keyrings/mysql.gpg 

# set signing key path
echo "deb [signed-by=/etc/apt/keyrings/mysql.gpg] http://repo.mysql.com/apt/${OS_NAME}/ ${OS_CODENAME} ${MYSQL_PACKAGE}" > /etc/apt/sources.list.d/mysql.list

apt-get update
apt-get upgrade

# configure default configuration
echo "mysql-community-server mysql-community-server/root-pass password ${MYSQL_ROOT_PASSWORD}" | debconf-set-selections
echo "myql-community-server mysql-community-server/re-root-pass password ${MYSQL_ROOT_PASSWORD}" | debconf-set-selections
echo "mysql-community-server mysql-server/default-auth-override select Use Legacy Authentication Method (Retain MySQL 5.x Compatibility)" | debconf-set-selections

# get my sql
DEBIAN_FRONTEND=noninteractive apt install -y mysql-server

# secure installation
( /usr/bin/mysqld_safe > /dev/null 2>&1 & ) \
&& ( while [ ! -S "/var/run/mysqld/mysqld.sock" ]; do sleep 1; done ) \
&& mysql_secure_installation -D --password=${MYSQL_ROOT_PASSWORD}

## install php-modules
apt-get install -y php libapache2-mod-php php-cli php-mysql

# create phpinfo-file
if [ "$CREATE_PHPINFO_FILE" = "true" ]; then echo "<?php echo phpinfo(); ?>" > /var/www/html/phpinfo.php; fi

## install phpmyadmin
( /usr/bin/mysqld_safe > /dev/null 2>&1 & )

echo "phpmyadmin phpmyadmin/dbconfig-install boolean false" | debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections

apt-get install -y phpmyadmin

# set web-server-url
ln -s /usr/share/phpmyadmin/ /var/www/html/${PHPMYADMIN_WEB_FOLDERNAME}

# register services
systemctl enable apache2
systemctl enable mysql
