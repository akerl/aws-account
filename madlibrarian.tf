module "akerl-hf-library" {
  source         = "armorfret/lambda-madlibrarian/aws"
  version        = "0.7.3"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-hf-library"
  data_bucket    = "akerl-hf-library"
  lambda_bucket  = module.akerl-madlibrarian.publish_bucket
  hostname       = "hf.coolquotes.xyz"
}

module "akerl-books-library" {
  source         = "armorfret/lambda-madlibrarian/aws"
  version        = "0.7.3"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-book-library"
  data_bucket    = "akerl-book-library"
  lambda_bucket  = module.akerl-madlibrarian.publish_bucket
  hostname       = "books.coolquotes.xyz"
}

module "akerl-dcs-library" {
  source         = "armorfret/lambda-madlibrarian/aws"
  version        = "0.7.3"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-dcs-library"
  data_bucket    = "akerl-dcs-library"
  lambda_bucket  = module.akerl-madlibrarian.publish_bucket
  hostname       = "dcs.coolquotes.xyz"
}

