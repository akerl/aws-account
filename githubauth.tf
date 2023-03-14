module "akerl-quote-auth" {
  source         = "armorfret/lambda-githubauth/aws"
  version        = "0.5.0"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-quote-auth"
  lambda_bucket  = module.akerl-githubauthlambda.publish_bucket
  hostname       = "auth.coolquotes.xyz"
}

module "akerl-private-auth" {
  source         = "armorfret/lambda-githubauth/aws"
  version        = "0.5.0"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-private-auth"
  lambda_bucket  = module.akerl-githubauthlambda.publish_bucket
  hostname       = "auth.scrtybybscrty.org"
}

