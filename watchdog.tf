module "akerl-watchdog-site" {
  source         = "armorfret/lambda-watchdog/aws"
  version        = "0.1.4"
  logging_bucket = module.account.logging_bucket
  config_bucket  = "akerl-watchdog-site"
  data_bucket    = "akerl-watchdog-site"
  lambda_bucket  = module.akerl-watchdog.publish_bucket
  hostname       = "watchdog.a-rwx.org"
  alert_email    = "me@lesaker.org"
}

