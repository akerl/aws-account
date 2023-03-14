module "akerl-watchdog-site" {
  source         = "armorfret/lambda-watchdog/aws"
  version        = "0.3.0"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-watchdog-site"
  data_bucket    = "akerl-watchdog-site"
  lambda_bucket  = module.akerl-watchdog.publish_bucket
  hostname       = "watchdog.a-rwx.org"
  alert_email    = "me@lesaker.org"
}

