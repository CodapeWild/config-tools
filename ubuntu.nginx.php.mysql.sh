#! /bin/bash

# ubuntu: 20.04
# nginx:
# php:
# mysql:

apt update
apt upgrade -y

apt install nginx -y

ufw allow "Nginx Full"
ufw allow ssh
ufw enable <<<'y'
ufw status

apt install mysql-server -y
# mysql_secure_installation <<<'y'
read -sp "set root@localhost password for mysql": pswd
mysql <<<"alter user 'root'@'localhost' identified with mysql_native_password by '${pswd}';flush privileges;select user, authentication_string, plugin, host from mysql.user where user='root';"

add-apt-repository universe

sysctl -w net.core.somaxconn=4096
