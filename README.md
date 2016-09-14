aws-account
===========

This is the terraform I use to configure my main AWS account

## Manual Steps

Some parts of the process are still manual, unfortunately

### Billing alarm SNS subscription

* Under SNS -> Topics -> billing-notif, subscribe my email address for email notifications (manual because terraform doesn't support SNS subscriptions that can't be autoconfirmed)

