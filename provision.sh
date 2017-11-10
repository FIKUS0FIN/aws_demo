#!/bin/bash

AWS_IP=$(cat ../aws_ip.conf)

AWS_ID=$(cat ../aws_id.conf)

echo $PWD
echo $TAG

#sed -ie "s/#SERVER_IP#/$AWS_IP/g" hosts

#cat hosts

#PARAM=$(echo ${JOB_NAME} | cut -d " " -f2)

#ansible-playbook -i hosts site.yml

if [[ ${KILL_PROVISION} == "True" ]]; then
  echo "killing box "
  aws ec2 terminate-instances --instance-ids $AWS_ID
fi
