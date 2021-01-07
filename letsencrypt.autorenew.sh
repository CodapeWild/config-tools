#! /bin/bash

apt update
apt upgrade -y

add-apt-repository ppa:certbot/certbot

apt install python-certbot-nginx -y

certbot --nginx
