#!/bin/bash
#####################################
#Author: Sabir Ali S K
#Date: 08-02-2025
#Version: v1
#Description: This script will report AWS resource usuage
####################################
# AWS S3
# AWS EC2
# AWS Lambda
# AWS IAM Users

set -x
set -e
set -o pipefail

echo "s3 bucket details >>>> "
# list s3 buckets
aws s3 ls
echo "ec2 instance details >>>>"
# list ec2 instances
#aws ec2 describe-instances
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'
echo "aws lambda function details >>>>"
# list aws lambda functions
aws lambda list-functions
echo "IAM user details >>>>"
# list IAM users
aws iam list-users