module "akerl-private-files" {
  source         = "armorfret/lambda-s3authproxy/aws"
  version        = "0.3.2"
  logging_bucket = module.account.logging_bucket
  config_bucket  = "akerl-private-files-config"
  data_bucket    = "akerl-private-files"
  lambda_bucket  = module.akerl-s3authproxy.publish_bucket
  hostname       = "files.scrtybybscrty.org"
}

module "akerl-coolquotes-share" {
  source         = "armorfret/lambda-s3authproxy/aws"
  version        = "0.3.2"
  logging_bucket = module.account.logging_bucket
  config_bucket  = "akerl-coolquotes-share-config"
  data_bucket    = "akerl-coolquotes-share"
  lambda_bucket  = module.akerl-s3authproxy.publish_bucket
  hostname       = "share.coolquotes.xyz"
}

