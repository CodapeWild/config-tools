#! /bin/bash

# ubuntu: 20.04
# letsencrypt:

apt update
apt upgrade -y

add-apt-repository ppa:certbot/certbot

apt install python-certbot-nginx
