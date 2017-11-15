#!/bin/bash

#function
##------------------------------------------------------------------------------
function kill_aws ()
{
  echo "killing box "
  aws ec2 terminate-instances --instance-ids $AWS_ID
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
kill_aws
