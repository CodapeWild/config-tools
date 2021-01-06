#! /bin/bash

set -e

apt update
apt install software-properties-common -y
add-apt-repository -y ppa:ondrej/php
apt update
apt upgrade -y

apt install nginx -y
apt install mysql-server -y
apt install php5.6-fpm php5.6-common php5.6-mysql php5.6-gd -y

read -sp "set root@localhost password for mysql":pswd
mysql <<<"alter user 'root'@'localhost' identified with mysql_native_password by '${pswd}';flush privileges;select user,host,authentication_string,plugin from mysql.user where user='root';"

ufw allow 'Nginx Full'
ufw allow ssh
ufw enable <<<'y'
ufw status

sysctl -w net.core.somaxconn=4096
