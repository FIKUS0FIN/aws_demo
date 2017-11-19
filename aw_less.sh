#!/bin/bash

## Creating Korobka
#awless create instance name=Jenkins image=ami-1e339e71 keypair=jenkins_2 \
#securitygroup=EC2SecurityGroup \


function maine
{
  if [[ $TAG == "none" ]]; then
    yes | awless create instance name=${NAME}*:_:*${TAG} image=ami-3f1bd150 keypair=jenkins_2 \
    subnet=subnet-4e64b325 securitygroup=@EC2SecurityGroup > raw.txt
    #statements
  else
    yes | awless create instance name=${NAME}*:_:*${TAG} image=ami-3f1bd150 keypair=jenkins_2 \
    subnet=subnet-4e64b325 securitygroup=@EC2SecurityGroup \
    userdata=https://raw.githubusercontent.com/FIKUS0FIN/aws_demo/master/provisionign_pakeges/${TAG}.sh > raw.txt
  fi

  AWS_ID=$(cat raw.txt | grep "instance = " | awk '{print $6}')
  yes | awless check instance id=$AWS_ID state=running
  sleep 10 
}

maine

#yes | awless create instance name=nginx image=ami-3f1bd150 keypair=jenkins_2 \
#subnet=subnet-4e64b325 securitygroup=@EC2SecurityGroup \
#userdata=https://raw.githubusercontent.com/FIKUS0FIN/aws_demo/master/${TAG}.sh
