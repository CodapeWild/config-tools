#! /bin/bash

apt update
apt install software-properties-common -y
add-apt-repository ppa:certbot/certbot
apt update
apt upgrade -y

apt install python-certbot-nginx -y

certbot --nginx
