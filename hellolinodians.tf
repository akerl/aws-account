module "akerl-hellolinodiansbot" {
  source         = "armorfret/lambda-hellolinodians/aws"
  version        = "0.0.4"
  logging-bucket = "${module.account.logging-bucket}"
  data-bucket    = "akerl-hellolinodians-config"
  lambda-bucket  = "akerl-gohellolinodians"
}
