module "akerl-quote-auth" {
  source         = "armorfret/lambda-githubauth/aws"
  version        = "0.1.0"
  logging_bucket = "${module.account.logging_bucket}"
  config_bucket  = "akerl-quote-auth"
  lambda_bucket  = "${module.akerl-githubauthlambda.publish_bucket}"
  hostname       = "auth.coolquotes.xyz"
}

module "akerl-private-auth" {
  source         = "armorfret/lambda-githubauth/aws"
  version        = "0.1.0"
  logging_bucket = "${module.account.logging_bucket}"
  config_bucket  = "akerl-private-auth"
  lambda_bucket  = "${module.akerl-githubauthlambda.publish_bucket}"
  hostname       = "auth.scrtybybscrty.org"
}
