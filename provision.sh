#!/bin/bash

AWS_IP=$(cat ../aws_ip.conf)
AWS_ID=$(cat ../aws_id.conf)
KILL_PROVISION=$(cat ../param.conf | grep "KILL" | awk '{print $2}')

echo $PWD ${PWD}
echo $TAG ${TAG}
echo $KEY ${KEY}

cd lamp_simple
printf "[all]\n$AWS_IP" > hosts
ansible-playbook -i ${AWS_IP} site.yml

if [[ ${KILL_PROVISION} == "True" ]]; then
  echo "killing box "
  aws ec2 terminate-instances --instance-ids $AWS_ID
fi
