#!/bin/bash

## Creating Korobka
#awless create instance name=Jenkins image=ami-1e339e71 keypair=jenkins_2 \
#securitygroup=EC2SecurityGroup \

awless create instance name=my_machine image=ami-3f1bd150 keypair={keypair.name} \
subnet={main.subnet} securitygroup={securitygroup} \
userdata=https://gist.github.com/FIKUS0FIN/985f88fb0c99dae4374976d0c52a06de
