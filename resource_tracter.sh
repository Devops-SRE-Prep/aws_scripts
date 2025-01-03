#!/bin/bash
#
##########################################
#Author: A Ajay Kumar
#
#Date: 04-01-2025
#
#Objective: Report s3, ec2, lambda, and IAM resources at 6 PM IST on a daily basis.
#
########################################
clear
set -x #debug mode
x=$(date)

# List s3 budget
echo "Print list of s3 buckets as of $x " > resourcetracker.txt
aws s3 ls >>  resourcetracker.txt


# List ec2 instances
echo "Print list of ec2 instances as of $x" >> resourcetracker.txt
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId' >>  resourcetracker.txt


# List Lambda
echo "Print list of Lambda functions as of $x" >>  resourcetracker.txt
aws lambda list-functions >>  resourcetracker.txt


# List IAM users
echo "Print list of IAM Users list as of $x" >>  resourcetracker.txt
aws iam list-users >>  resourcetracker.txt

# Send the output as an email
cat resourcetracker.txt | mail -s "Hourly AWS Resource Report" ajaykumar@gmail.com

