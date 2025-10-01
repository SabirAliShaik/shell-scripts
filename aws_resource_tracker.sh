#!/bin/bash
#####################################
#Author: Sabir Ali S K / Devops Team
#Date: 01-10-2025
#Version: v2
#Description: This script will report AWS resource usuage
####################################
# Following resources will be tracked by this script
# AWS S3
# AWS EC2
# AWS Lambda
# AWS IAM Users
# AWS RDS
# AWS VPC
# AWS CloudFront
# AWS CloudWatch
# AWS EBS
# AWS SNS
# AWS SQS
# AWS ELB
# AWS DynamoDB
# AWS Route53
# AWS CloudFormation

# Usage: bash aws_resource_tracker.sh <region> <service>
# Example: bash aws_resource_tracker.sh us-east-1 s3
####################################


set -x
set -e
set -o pipefail

if [ "$#" -ne 2 ]; then
    echo "$0: Invalid number of arguments, usage: bash $0 <region> <service>"
    exit 1
fi

aws_region=$1
aws_service=$2

# Check if aws is installed
if ! command -v aws &> /dev/null
then
    echo "aws cli could not be found, please install aws cli"
    exit
fi  

# Check if aws is configured
if ! aws sts get-caller-identity &> /dev/null
then
    echo "aws cli is not configured, please configure aws cli"
    exit
fi  

case $aws_service in
    "ec2")
        aws ec2 describe-instances --region $aws_region
        ;;
    "s3")
        aws s3 ls --region $aws_region
        ;;
    "lambda")
        aws lambda list-functions --region $aws_region
        ;;
    "iam")
        aws iam list-users
        ;;
    "rds")
        aws rds describe-db-instances --region $aws_region
        ;;
    "vpc")
        aws ec2 describe-vpcs --region $aws_region
        ;;
    "cloudfront")
        aws cloudfront list-distributions
        ;;
    "cloudwatch")
        aws cloudwatch describe-alarms --region $aws_region
        ;;
    "ebs")
        aws ec2 describe-volumes --region $aws_region
        ;;
    "sns")
        aws sns list-topics --region $aws_region
        ;;
    "sqs")
        aws sqs list-queues --region $aws_region
        ;;
    "elb")
        aws elb describe-load-balancers --region $aws_region
        ;;
    "dynamodb")
        aws dynamodb list-tables --region $aws_region
        ;;
    "route53")
        aws route53 list-hosted-zones
        ;;
    "cloudformation")
        aws cloudformation describe-stacks --region $aws_region
        ;;
    *)
        echo "Invalid service name, please provide a valid service name"
        exit 1
        ;;
esac

echo "Execution completed  successfully"
