module "dock0-arch" {
  source         = "armorfret/lambda-hookshot/aws"
  version        = "0.0.6"
  logging_bucket = "${module.account.logging_bucket}"
  lambda_bucket  = "akerl-hookshot"
  config_bucket  = "dock0-arch"
}
