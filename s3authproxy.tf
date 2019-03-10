module "akerl-private-files" {
  source         = "armorfret/lambda-s3authproxy/aws"
  version        = "0.0.4"
  logging-bucket = "${module.account.logging-bucket}"
  config-bucket  = "akerl-private-files-config"
  data-bucket    = "akerl-private-files"
  lambda-bucket  = "${module.akerl-s3authproxy.publish-bucket}"
  domain         = "files.scrtybybscrty.org"
}
