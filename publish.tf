module "akerl-s3authproxy" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.2.4"
  logging_bucket = module.account.logging_bucket
  publish_bucket = "akerl-s3authproxy"
}

module "akerl-madlibrarian" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.2.4"
  publish_bucket = "akerl-madlibrarian"
  logging_bucket = module.account.logging_bucket
}

module "akerl-githubauthlambda" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.2.4"
  publish_bucket = "akerl-githubauthlambda"
  logging_bucket = module.account.logging_bucket
}

module "akerl-watchdog" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.2.4"
  publish_bucket = "akerl-watchdog"
  logging_bucket = module.account.logging_bucket
}

module "akerl-goat-backup" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.2.4"
  publish_bucket = "akerl-goat-backup"
  logging_bucket = module.account.logging_bucket
}
