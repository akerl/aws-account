module "akerl-private-files" {
  source         = "armorfret/lambda-s3authproxy/aws"
  version        = "0.0.5"
  logging_bucket = "${module.account.logging_bucket}"
  config_bucket  = "akerl-private-files-config"
  data_bucket    = "akerl-private-files"
  lambda_bucket  = "${module.akerl-s3authproxy.publish_bucket}"
  hostname       = "files.scrtybybscrty.org"
}
