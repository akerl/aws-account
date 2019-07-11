module "akerl-hellolinodiansbot" {
  source         = "armorfret/lambda-hellolinodians/aws"
  version        = "0.1.0"
  logging_bucket = module.account.logging_bucket
  config_bucket  = "akerl-hellolinodians-config"
  lambda_bucket  = "akerl-gohellolinodians"
}

