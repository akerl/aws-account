module "akerl-hookshot" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.0.2"
  publish_bucket = "akerl-hookshot"
  logging_bucket = "${module.account.logging_bucket}"
}

module "akerl-relay" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.0.2"
  publish_bucket = "akerl-relay"
  logging_bucket = "${module.account.logging_bucket}"
}

module "akerl-s3authproxy" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.0.2"
  logging_bucket = "${module.account.logging_bucket}"
  publish_bucket = "akerl-s3authproxy"
}

module "akerl-gohellolinodians" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.0.2"
  logging_bucket = "${module.account.logging_bucket}"
  publish_bucket = "akerl-gohellolinodians"
}

module "akerl-snstoslack" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.0.2"
  logging_bucket = "${module.account.logging_bucket}"
  publish_bucket = "akerl-snstoslack"
}

module "akerl-madlibrarian" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.0.2"
  publish_bucket = "akerl-madlibrarian"
  logging_bucket = "${module.account.logging_bucket}"
}

module "akerl-githubauthlambda" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.0.2"
  publish_bucket = "akerl-githubauthlambda"
  logging_bucket = "${module.account.logging_bucket}"
}
