#!/bin/bash

## creating Korobka
AWS_ID=$(aws ec2 run-instances   --image-id ami-1e339e71 --key-name jenkins --security-groups EC2SecurityGroup --instance-type t2.micro --output text | grep INSTANCES | awk '{print $7}' )
echo "KOROBKA ID is :: $AWS_ID"

## checking Koroaka state
while [[ $(aws ec2 describe-instances --query 'Reservations[*].Instances[*].[State.Name, InstanceId]' --output text | grep "running" | grep "$AWS_ID" | wc -l) -eq 0 ]]
do
  sleep 2
  echo "WATING FOR KOROBKA"
done
echo "Kobobka is running"
sleep 15

## Adding TAG to Korobka
echo "Taging Korobka with Key and Tag  :: ${TAG} :: ${KEY} "
aws ec2 create-tags --resources $AWS_ID --tags Key=${KEY},Value=${TAG}

## getting IP-addr Instance
AWS_DNS=$(aws ec2 describe-instances --output text --instance-ids $AWS_ID | grep ASSOCIATION | awk '{print $3}' | sort -u)
echo "getting DNS of the Instance :: $AWS_DNS "

## getting result form Korobka
aws ec2 describe-instances --instance-ids $AWS_ID

## terminating Korobka
if [[ ${KILL} == "True" ]]; then
  echo "killing box "
  aws ec2 terminate-instances --instance-ids $AWS_ID
fi

echo $AWS_ID > ../aws_id.conf
echo $AWS_DNS > ../aws_DNS.conf
printf "TAG ${TAG}\nKEY ${KEY}\nKILL ${KILL_PROVISION}\n" > ../param.conf
