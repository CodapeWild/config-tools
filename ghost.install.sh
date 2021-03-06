#! /bin/bash
# ubuntu system prerequisite config for ghost blog

set -e

apt update
apt upgrade -y

apt install nginx certbot python3-certbot-nginx -y

read -p "add new user for ghost installation": newuser
useradd -ms /bin/bash $newuser
usermod -aG sudo $newuser
passwd $newuser

apt install mysql-server -y
read -p "set db name for ghost": dbname
read -sp "set password for ${newuser}@localhost of mysql": pswd
mysql <<<"create user '${newuser}'@'localhost' identified with mysql_native_password by '${pswd}';grant all privileges on ${dbname}.* to '${newuser}'@'localhost';flush privileges;select user,host,authentication_string,plugin from mysql.user where user='${newuser}';"

ufw allow 'Nginx Full'
ufw allow ssh
ufw enable <<<'y'
ufw status

sysctl -w net.core.somaxconn=4096

curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash
apt install nodejs -y

npm install ghost-cli@latest -g
mkdir -p /var/www/ghost
chown ${newuser}:${newuser} /var/www/ghost
chmod -R 755 /var/www/ghost

su $newuser
cd /var/www/ghost
ghost install
