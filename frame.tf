module "akerl-frame-site" {
  source         = "armorfret/lambda-frame/aws"
  version        = "0.3.0"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-frame-data"
  data_bucket    = "akerl-frame-photos"
  lambda_bucket  = module.akerl-frame.publish_bucket
  hostname       = "frame.akerl.app"

  auth_lambda_bucket = "akerl-lambda-basic-auth"
  auth_config_bucket = "akerl-frame-auth"
}

resource "aws_route53_record" "a_frame_akerl_app" {
  zone_id = module.zones["akerl.app"].zone_id
  name    = "frame.akerl.app"
  type    = "A"

  alias {
    name                   = module.akerl-frame-site.dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}
