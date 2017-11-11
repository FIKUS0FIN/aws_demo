#!/bin/bash
echo "start"
echo "function name kill_aws"

aws=1

function kill_aws ()
{
  if [[ $1 == "1" ]]; then
    echo "killing box "
    echo "$1"
  fi
}

kill_aws $aws

function aws_test
{
  echo "start aws_test"
  aws=212
  #statements
}

aws_test
echo $aws

function grep_aws_id
{
  #-----------------------------------------------------------------------------
  AWS_ID=$(aws ec2 run-instances   --image-id ami-1e339e71 --key-name jenkins --security-groups EC2SecurityGroup --instance-type t2.micro --output text | grep INSTANCES | awk '{print $7}' )
  echo "KOROBKA ID is :: $AWS_ID"
}

function checking_aws_state
{
  while [[ $(aws ec2 describe-instances --query 'Reservations[*].Instances[*].[State.Name, InstanceId]' --output text | grep "running" | grep "$1" | wc -l) -eq 0 ]]
  do
    sleep 2
    echo "WATING FOR KOROBKA"
  done
  echo "Kobobka is running"
  sleep 15
}

function taging_aws_box
{
  echo "Taging Korobka with Key and Tag  :: ${TAG} :: ${KEY} "
  aws ec2 create-tags --resources $1 --tags Key=${KEY},Value=${TAG}
}

function getting_dns_aws_box
{
  AWS_DNS=$(aws ec2 describe-instances --output text --instance-ids $1 | grep ASSOCIATION | awk '{print $3}' | sort -u)
  echo "getting DNS of the Instance :: $AWS_DNS "
}

function aws_result
{
  aws ec2 describe-instances --instance-ids $AWS_ID
}

function kill_aws ()
{
  if [[ $1 == "True" ]]; then
    echo "killing box "
    aws ec2 terminate-instances --instance-ids $AWS_ID
  fi
}

grep_aws_id $AWS_ID
taging_aws_box $AWS_ID
getting_dns_aws_box $AWS_ID
kill_aws $KILL
