module "akerl-blindclock-site" {
  source         = "armorfret/lambda-blindclock/aws"
  version        = "0.3.0"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-blindclock-data"
  data_bucket    = "akerl-blindclock-data"
  lambda_bucket  = module.akerl-blindclock.publish_bucket
  hostname       = "poker.akerl.app"
}

resource "aws_route53_record" "a_poker_akerl_app" {
  zone_id = module.zones["akerl.app"].zone_id
  name    = "poker.akerl.app"
  type    = "A"

  alias {
    name                   = module.akerl-blindclock-site.dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}
