module "akerl-frame-site" {
  source         = "armorfret/lambda-frame/aws"
  version        = "0.1.1"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-frame-data"
  data_bucket    = "akerl-frame-photos"
  lambda_bucket  = module.akerl-frame.publish_bucket
  hostname       = "frame.akerl.app"

  auth_lambda_bucket = "akerl-lambda-basic-auth"
  auth_config_bucket = "akerl-frame-auth"
}
