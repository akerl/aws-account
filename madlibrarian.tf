module "akerl-hf-library" {
  source         = "armorfret/lambda-madlibrarian/aws"
  version        = "0.7.4"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-hf-library"
  data_bucket    = "akerl-hf-library"
  lambda_bucket  = module.akerl-madlibrarian.publish_bucket
  hostname       = "hf.coolquotes.xyz"
}

module "akerl-books-library" {
  source         = "armorfret/lambda-madlibrarian/aws"
  version        = "0.7.4"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-book-library"
  data_bucket    = "akerl-book-library"
  lambda_bucket  = module.akerl-madlibrarian.publish_bucket
  hostname       = "books.coolquotes.xyz"
}

module "akerl-dcs-library" {
  source         = "armorfret/lambda-madlibrarian/aws"
  version        = "0.7.4"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-dcs-library"
  data_bucket    = "akerl-dcs-library"
  lambda_bucket  = module.akerl-madlibrarian.publish_bucket
  hostname       = "dcs.coolquotes.xyz"
}

resource "aws_route53_record" "a_hf_coolquotes_xyz" {
  zone_id = module.zones["coolquotes.xyz"].zone_id

  name = "hf.coolquotes.xyz"
  type = "A"

  alias {
    name                   = module.akerl-hf-library.dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_books_coolquotes_xyz" {
  zone_id = module.zones["coolquotes.xyz"].zone_id

  name = "books.coolquotes.xyz"
  type = "A"

  alias {
    name                   = module.akerl-books-library.dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_dcs_coolquotes_xyz" {
  zone_id = module.zones["coolquotes.xyz"].zone_id

  name = "dcs.coolquotes.xyz"
  type = "A"

  alias {
    name                   = module.akerl-dcs-library.dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}
