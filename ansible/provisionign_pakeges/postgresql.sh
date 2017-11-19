#!/bin/bash
sudo apt update
sudo apt install -y --no-install-recommends python-minimal
sudo apt install -y postgresql postgresql-contrib
sudo service postgresql restart
