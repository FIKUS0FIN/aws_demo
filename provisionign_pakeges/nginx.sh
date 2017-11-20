#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install -y nginx
sudo systemctl restart nginx
sudo apt-get install -y --no-install-recommends python-minimal
