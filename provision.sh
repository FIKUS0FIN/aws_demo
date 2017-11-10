#!/bin/bash

AWS_DNS=$(cat ../aws_DNS.conf)
AWS_ID=$(cat ../aws_id.conf)
KILL_PROVISION=$(cat ../param.conf | grep "KILL" | awk '{print $2}')
TAG=$(cat ../param.conf | grep "TAG" | awk '{print $2}')
KEY=$(cat ../param.conf | grep "KEY" | awk '{print $2}')

echo $PWD ${PWD}
echo $TAG ${TAG}
echo $KEY ${KEY}
echo $AWS_DNS

sleep 30
cd ansible
echo $PWD
#printf "$AWS_IP" >> hosts
#ansible-playbook -i hosts prepare_ansible_target.yml
#ansible-playbook prepare_ansible_target.yml -i hosts --extra-vars "all=$AWS_DNS"
ansible-playbook -i $AWS_DNS, jenkins.yml

if [[ ${KILL_PROVISION} == "True" ]]; then
  echo "killing box "
  aws ec2 terminate-instances --instance-ids $AWS_ID
fi
