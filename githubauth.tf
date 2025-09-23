module "akerl-quote-auth" {
  source         = "armorfret/lambda-githubauth/aws"
  version        = "0.9.2"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-quote-auth"
  lambda_bucket  = module.akerl-githubauthlambda.publish_bucket
  hostname       = "auth.quotes.akerl.org"
}

resource "aws_route53_record" "a_auth_quotes_akerl_org" {
  zone_id = module.zones["akerl.org"].zone_id

  name = "auth.quotes.akerl.org"
  type = "A"

  alias {
    name                   = module.akerl-quote-auth.dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}
