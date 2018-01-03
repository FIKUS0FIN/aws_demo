#!/bin/bash

## Creating Korobka
#-------------------------------------------------------------------------------
# create Amazon EC2 instance, Name it and *Tag in to do
# grep AWS_ID and primary provisioning * none.sh simple-python pakege *
# wait antil state == running
# KILL function * terminate-instances if ${KILL} if == "TRUE"
##------------------------------------------------------------------------------

function root
{

  ##----------------------------------------------------------------------------
  yes | awless create instance name=${NAME}*:_:*${TAG} image=ami-3f1bd150 keypair=ubuntu \
  subnet=subnet-4e64b325 securitygroup=@EC2SecurityGroup \
  userdata=https://raw.githubusercontent.com/FIKUS0FIN/aws_demo/master/provisionign_pakeges/py_min.sh > raw.txt
  ##----------------------------------------------------------------------------

  AWS_ID=$(cat raw.txt | grep "instance = " | awk '{print $6}')
  AWS_DNS=$(awless show $AWS_ID | grep PublicDNS | awk '{print $4}')
  echo "$AWS_DNS" > ../aws_DNS.conf
  echo "$AWS_ID" > ../aws_id.conf
  yes | awless check instance id=$AWS_ID state=running
  yes | awless create tag key=TAG resource=$AWS_ID value=${TAG}
  awless show $AWS_ID
  sleep 10
}

function kill_aws ()
{
  if [[ ${KILL} == "True" ]]; then
    echo "killing box "
    aws ec2 terminate-instances --instance-ids $AWS_ID
  fi
}
#-------------------------------------------------------------------------------
root
kill_aws ${KILL}

#yes | awless create instance name=nginx image=ami-3f1bd150 keypair=jenkins_2 \
#subnet=subnet-4e64b325 securitygroup=@EC2SecurityGroup \
#userdata=https://raw.githubusercontent.com/FIKUS0FIN/aws_demo/master/${TAG}.sh
