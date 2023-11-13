#!/bin/bash

sudo yum install amazon-cloudwatch-agent -y

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c ssm:/Lab/asgLab -s
