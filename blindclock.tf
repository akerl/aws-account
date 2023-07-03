module "akerl-blindclock-site" {
  source         = "armorfret/lambda-blindclock/aws"
  version        = "0.1.3"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-blindclock-data"
  data_bucket    = "akerl-blindclock-data"
  lambda_bucket  = module.akerl-blindclock.publish_bucket
  hostname       = "poker.akerl.app"
}
