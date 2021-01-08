#! /bin/bash

apt update
apt install certbot python-certbot-nginx -y

certbot --nginx
