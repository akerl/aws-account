module "akerl-hook-site" {
  source         = "armorfret/lambda-hookexporter/aws"
  version        = "0.3.4"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-hookexporter-config"
  data_bucket    = "akerl-hookexporter-data"
  lambda_bucket  = module.akerl-hookexporter.publish_bucket
  hostname       = "exporter.akerl.org"
}

resource "aws_route53_record" "a_exporter_akerl_org" {
  zone_id = module.zones["akerl.org"].zone_id
  name    = "exporter.akerl.org"
  type    = "A"

  alias {
    name                   = module.akerl-hook-site.dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}
