module "akerl-hookshot" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.0.1"
  publish-bucket = "akerl-hookshot"
  logging-bucket = "${module.account.logging-bucket}"
}

module "akerl-relay" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.0.1"
  publish-bucket = "akerl-relay"
  logging-bucket = "${module.account.logging-bucket}"
}

module "akerl-s3authproxy" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.0.1"
  logging-bucket = "${module.account.logging-bucket}"
  publish-bucket = "akerl-s3authproxy"
}

module "akerl-gohellolinodians" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.0.1"
  logging-bucket = "${module.account.logging-bucket}"
  publish-bucket = "akerl-gohellolinodians"
}

module "akerl-snstoslack" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.0.1"
  logging-bucket = "${module.account.logging-bucket}"
  publish-bucket = "akerl-snstoslack"
}

module "akerl-madlibrarian" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.0.1"
  publish-bucket = "akerl-madlibrarian"
  logging-bucket = "${module.account.logging-bucket}"
}

module "akerl-githubauthlambda" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.0.1"
  publish-bucket = "akerl-githubauthlambda"
  logging-bucket = "${module.account.logging-bucket}"
}
