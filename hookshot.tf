module "hourly" {
  source         = "armorfret/lambda-hookshot/aws"
  version        = "0.2.2"
  logging_bucket = module.account.logging_bucket
  lambda_bucket  = "akerl-hookshot"
  config_bucket  = "hookshot-hourly"
}

