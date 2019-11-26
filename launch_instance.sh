#!/bin/bash

instance_type=t3.micro

if [ -n "$1" ]; then 
    instance_type="$1"
fi

username=RoyalTundraWolfpack

tag_specification='[{"ResourceType": "instance", "Tags": [{"Key": "Name", "Value": "tsung-'${username}'"}]}, {"ResourceType": "volume", "Tags": [{"Key": "Name", "Value": "tsung-'${username}'"}]}]'

instance_id=$(aws ec2 run-instances \
  --image-id ami-f62afe8e \
  --instance-type ${instance_type} \
  --key-name RoyalTundraWolfpack \
  --security-group-ids sg-0ebf2c62af41a0eb1 \
  --tag-specifications "${tag_specification}" | jq -r .Instances[0].InstanceId)

echo "InstanceId: ${instance_id}"

public_ip=$(aws ec2 describe-instances --instance-ids "${instance_id}" | jq -r .Reservations[0].Instances[0].PublicIpAddress)

echo "ssh command: ssh -i ~/RoyalTundraWolfpack.pem ec2-user@${public_ip}"
echo "tsung dashboard: https//${public_ip}:8091"
