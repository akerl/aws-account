module "akerl-frame-site" {
  source         = "armorfret/lambda-frame/aws"
  version        = "0.0.3"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-frame-data"
  data_bucket    = "akerl-frame-photos"
  lambda_bucket  = module.akerl-frame.publish_bucket
  hostname       = "frame.akerl.app"
}
