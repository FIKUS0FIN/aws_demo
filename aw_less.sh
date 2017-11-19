#!/bin/bash

## Creating Korobka
#awless create instance name=Jenkins image=ami-1e339e71 keypair=jenkins_2 \
#securitygroup=EC2SecurityGroup \

awless create instance name=nginx image=ami-3f1bd150 keypair=jenkins_2 \
subnet=subnet-4e64b325 securitygroup=@EC2SecurityGroup \
userdata=https://raw.githubusercontent.com/FIKUS0FIN/aws_demo/master/py_min.sh
