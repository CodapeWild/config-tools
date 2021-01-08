#! /bin/bash
# install ssl certificate and nginx plugin

apt update
apt install certbot python-certbot-nginx -y

certbot --nginx
