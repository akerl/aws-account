module "akerl-quote-auth" {
  source         = "armorfret/lambda-githubauth/aws"
  version        = "0.7.5"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-quote-auth"
  lambda_bucket  = module.akerl-githubauthlambda.publish_bucket
  hostname       = "auth.coolquotes.xyz"
}

resource "aws_route53_record" "a_auth_coolquotes_xyz" {
  zone_id = module.zones["coolquotes.xyz"].zone_id

  name = "auth.coolquotes.xyz"
  type = "A"

  alias {
    name                   = module.akerl-quote-auth.dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}

module "akerl-private-auth" {
  source         = "armorfret/lambda-githubauth/aws"
  version        = "0.7.5"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-private-auth"
  lambda_bucket  = module.akerl-githubauthlambda.publish_bucket
  hostname       = "auth.scrtybybscrty.org"
}

resource "aws_route53_record" "a_auth_scrtybybscrty_org" {
  zone_id = module.zones["scrtybybscrty.org"].zone_id
  name    = "auth.scrtybybscrty.org"
  type    = "A"

  alias {
    name                   = module.akerl-private-auth.dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}
