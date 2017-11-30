#!/bin/bash

## Creating Korobka
#-------------------------------------------------------------------------------
# create Amazon EC2 instance, Name it and *Tag in to do
# grep AWS_ID and primary provisioning * none.sh simple-python pakege *
# wait antil state == running
# KILL function * terminate-instances if ${KILL} if == "TRUE"
##------------------------------------------------------------------------------
function maine
{
  ##----------------------------------------------------------------------------
  yes|awless create instance name=${NAME} image=ami-c4ff70ab keypair=ubuntu subnet=subnet-4e64b325 securitygroup=sg-b8a4c4d2 > raw.txt
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
maine
kill_aws ${KILL}
