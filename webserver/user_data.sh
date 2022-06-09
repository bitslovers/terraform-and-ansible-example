#!/bin/bash -xe

# Make sure that the AMI is Amazon Linux 2
amazon-linux-extras install ansible2=2.8 -y
yum install -y zip unzip

cd /root/
aws s3 cp s3://${s3_bucket}/terraform/${zip} /root/ansible_script.zip

unzip ansible_script.zip

export S3_BUCKET=${s3_bucket}
export environment=${environment}


ansible-playbook -i "127.0.0.1," provision.yml --connection=local
