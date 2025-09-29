#!/bin/bash
if [ $# -gt 0 ]
then
        aws --version > /dev/null 2>&1
        if [ $? -eq 0 ]
        then
                REGIONS=$@
                for region in $REGIONS
                do
                        aws ec2 describe-vpcs --region $region | jq -r ".Vpcs[].VpcId" 
                done
        else
                echo "Please check your AWS CLI installation."
                exit 1
        fi
else
        echo "Invalid paramers. Please pass regions"
        exit 1
fi
