#!/bin/bash

#function
##------------------------------------------------------------------------------
function kill_aws ()
{
  if [[ $1 == "True" ]]; then
    echo "killing box "
    aws ec2 terminate-instances --instance-ids $AWS_ID
  fi
}

function ansible_task ()
{
  cd ansible
  echo $PWD
  printf "$AWS_DNS\n" > hosts
  ansible-playbook -vv  -i hosts --private-key=~/.ssh/jenkins_2.pem python_2.yml
  ansible-playbook -vv  -i hosts --private-key=~/.ssh/jenkins_2.pem $1.yml
  exit
}

function aws_result ()
{
  echo "AWS box wass created with TAG :: $TAG"
  echo "AWS DNS name is :: $AWS_DNS"
  echo "AWS ID is :: $AWS_ID"
  echo "AWS TAG and KEY is :: $TAG :: $KEY"
}

#ARGS
##------------------------------------------------------------------------------
AWS_DNS=$(cat ../aws_DNS.conf)
AWS_ID=$(cat ../aws_id.conf)
KILL_PROVISION=$(cat ../param.conf | grep "KILL" | awk '{print $2}')
TAG=$(cat ../param.conf | grep "TAG" | awk '{print $2}')
KEY=$(cat ../param.conf | grep "KEY" | awk '{print $2}')

aws_result

if [[ $TAG == "none" ]]; then
    aws_result
  else
    ansible_task $TAG
    aws_result
fi

kill_aws $KILL_PROVISION
