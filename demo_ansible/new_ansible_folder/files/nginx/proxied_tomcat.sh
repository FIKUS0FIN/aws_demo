#!/bin/bash

# Installing nginx + ssl
IP_ADDRESS="$(ifconfig | egrep -o -m 1 'inet addr:[0-9|.]+' | egrep -o '[0-9|.]+')"

# Set Defaults
OPT_A="8080"
SERVER_NAME=$IP_ADDRESS

shift $((OPTIND-1))  #This tells getopts to move on to the next argument.

sudo add-apt-repository -y ppa:nginx/stable
sudo apt-get update
sudo apt-get -y install nginx
cp local.conf /etc/nginx/conf.d/local.conf
mkdir -p /etc/nginx/ssl
cp ssl.rules /etc/nginx/ssl/ssl.rules
cp nginx.conf /etc/nginx/nginx.conf

# Generate the Keys

    mkdir -p /etc/nginx/ssl/keys
    openssl genpkey -algorithm RSA -out /etc/nginx/ssl/keys/private.key -pkeyopt rsa_keygen_bits:2048
    openssl rsa -in /etc/nginx/ssl/keys/private.key -out /etc/nginx/ssl/keys/private-decrypted.key
    openssl req -new -sha256 -key /etc/nginx/ssl/keys/private-decrypted.key -subj "/CN=$SERVER_NAME" -out /etc/nginx/ssl/keys/$SERVER_NAME.csr
    openssl x509 -req -days 365 -in /etc/nginx/ssl/keys/$SERVER_NAME.csr -signkey /etc/nginx/ssl/keys/private.key -out /etc/nginx/ssl/keys/server.crt
    rm /etc/nginx/ssl/keys/private-decrypted.key
    rm /etc/nginx/ssl/keys/$SERVER_NAME.csr

openssl dhparam -outform pem -out /etc/nginx/ssl/dhparam2048.pem 2048

sed -i "s/SERVER_NAME/$SERVER_NAME/" /etc/nginx/conf.d/local.conf
sed -i "s/PORT_NUMBER/$OPT_A/" /etc/nginx/conf.d/local.conf

sudo service nginx restart

# install tomcat
##------------------------------------------------------------------------------
