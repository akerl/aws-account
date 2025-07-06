module "akerl-watchdog-site" {
  source         = "armorfret/lambda-watchdog/aws"
  version        = "0.8.0"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-watchdog-site"
  data_bucket    = "akerl-watchdog-site"
  lambda_bucket  = module.akerl-watchdog.publish_bucket
  hostname       = "watchdog.akerl.app"
  alert_email    = "me@lesaker.org"
}

resource "aws_route53_record" "a_watchdog_akerl_app" {
  zone_id = module.zones["akerl.app"].zone_id

  name = "watchdog.akerl.app"
  type = "A"

  alias {
    name                   = module.akerl-watchdog-site.dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}

module "akerl-osrs-site" {
  source         = "armorfret/lambda-watchdog/aws"
  version        = "0.8.0"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-osrs-site"
  data_bucket    = "akerl-osrs-site"
  lambda_bucket  = module.akerl-watchdog.publish_bucket
  hostname       = "osrs.akerl.app"
  alert_email    = "me@lesaker.org"
  rate           = 300
}

resource "aws_route53_record" "a_osrs_akerl_app" {
  zone_id = module.zones["akerl.app"].zone_id

  name = "osrs.akerl.app"
  type = "A"

  alias {
    name                   = module.akerl-osrs-site.dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}
