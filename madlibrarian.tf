module "akerl-hf-library" {
  source         = "armorfret/lambda-madlibrarian/aws"
  version        = "0.9.2"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-hf-library"
  data_bucket    = "akerl-hf-library"
  lambda_bucket  = module.akerl-madlibrarian.publish_bucket
  hostname       = "hf.quotes.akerl.org"
}

module "akerl-books-library" {
  source         = "armorfret/lambda-madlibrarian/aws"
  version        = "0.9.2"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-book-library"
  data_bucket    = "akerl-book-library"
  lambda_bucket  = module.akerl-madlibrarian.publish_bucket
  hostname       = "books.quotes.akerl.org"
}

module "akerl-dcs-library" {
  source         = "armorfret/lambda-madlibrarian/aws"
  version        = "0.9.2"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-dcs-library"
  data_bucket    = "akerl-dcs-library"
  lambda_bucket  = module.akerl-madlibrarian.publish_bucket
  hostname       = "dcs.quotes.akerl.org"
}

resource "aws_route53_record" "a_hf_quotes_akerl_org" {
  zone_id = module.zones["akerl.org"].zone_id

  name = "hf.quotes.akerl.org"
  type = "A"

  alias {
    name                   = module.akerl-hf-library.dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_books_quotes_akerl_org" {
  zone_id = module.zones["akerl.org"].zone_id

  name = "books.quotes.akerl.org"
  type = "A"

  alias {
    name                   = module.akerl-books-library.dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_dcs_quotes_akerl_org" {
  zone_id = module.zones["akerl.org"].zone_id

  name = "dcs.quotes.akerl.org"
  type = "A"

  alias {
    name                   = module.akerl-dcs-library.dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}
