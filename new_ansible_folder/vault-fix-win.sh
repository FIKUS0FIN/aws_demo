#!/bin/bash
sed -i 's/\r/\n/g' vault-password.txt
sed -i 's/\r/\n/g' secret_vars/tomcat.yml
