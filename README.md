aws-account
===========

[![Build Status](https://img.shields.io/circleci/project/akerl/aws-account/master.svg)](https://circleci.com/gh/akerl/aws-account)

This is the terraform I use to configure my main AWS account

## Manual Steps

Some parts of the process are still manual, unfortunately

### Billing alarm SNS subscription

* Under SNS -> Topics -> billing-notif, subscribe my email address for email notifications (manual because terraform doesn't support SNS subscriptions that can't be autoconfirmed)

### Blog CloudFront SSL certificate

* Under ACM, request a cert for all the CNAMEs on your blog and then set the ARN in akerl/blog/main.tf (manual because terraform doesn't support certificate generates, which require out-of-band confirmation via email)

