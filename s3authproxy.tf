module "akerl-private-files" {
  source         = "armorfret/lambda-s3authproxy/aws"
  version        = "0.7.7"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-private-files-config"
  data_bucket    = "akerl-private-files"
  lambda_bucket  = module.akerl-s3authproxy.publish_bucket
  hostname       = "files.scrtybybscrty.org"
}

resource "aws_route53_record" "a_files_scrtybybscrty_org" {
  zone_id = module.zones["scrtybybscrty.org"].zone_id
  name    = "files.scrtybybscrty.org"
  type    = "A"

  alias {
    name                   = module.akerl-private-files.dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}

module "akerl-coolquotes-share" {
  source         = "armorfret/lambda-s3authproxy/aws"
  version        = "0.7.7"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-coolquotes-share-config"
  data_bucket    = "akerl-coolquotes-share"
  lambda_bucket  = module.akerl-s3authproxy.publish_bucket
  hostname       = "share.coolquotes.xyz"
}

resource "aws_route53_record" "a_share_coolquotes_xyz" {
  zone_id = module.zones["coolquotes.xyz"].zone_id

  name = "share.coolquotes.xyz"
  type = "A"

  alias {
    name                   = module.akerl-coolquotes-share.dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}
