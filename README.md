aws-account
===========

[![Build Status](https://img.shields.io/travis/com/akerl/aws-account.svg)](https://travis-ci.com/akerl/aws-account)

This is the terraform I use to configure my main AWS account

## Manual Steps

Some parts of the process are still manual, unfortunately

### Enable IAM access to billing

My Account -> IAM User and Role Access to Billing Information -> enable

Must be done via root account

### Disable Security Token Service Regions other than us-east-1

IAM -> Account Settings -> "Security Token Service Regions" -> Disable all regions except us-east-1

