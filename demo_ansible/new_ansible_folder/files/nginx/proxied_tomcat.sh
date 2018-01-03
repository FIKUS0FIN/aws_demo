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
cp nginx.conf /etc/nginx/nginx.conf


sed -i "s/SERVER_NAME/$SERVER_NAME/" /etc/nginx/conf.d/local.conf
sed -i "s/PORT_NUMBER/$OPT_A/" /etc/nginx/conf.d/local.conf

sudo service nginx restart

# install tomcat
##------------------------------------------------------------------------------
