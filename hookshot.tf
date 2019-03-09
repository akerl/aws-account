module "dock0-arch" {
  source         = "armorfret/lambda-hookshot/aws"
  version        = "0.0.3"
  logging-bucket = "${module.account.logging-bucket}"
  lambda-bucket  = "akerl-hookshot"
  data-bucket    = "dock0-arch"
}
