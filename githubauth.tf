module "akerl-quote-auth" {
  source         = "armorfret/lambda-githubauth/aws"
  version        = "0.0.3"
  logging-bucket = "${module.account.logging-bucket}"
  config-bucket  = "akerl-quote-auth"
  lambda-bucket  = "${module.akerl-githubauthlambda.publish-bucket}"
  domain         = "auth.coolquotes.xyz"
}

module "akerl-private-auth" {
  source         = "armorfret/lambda-githubauth/aws"
  version        = "0.0.3"
  logging-bucket = "${module.account.logging-bucket}"
  config-bucket  = "akerl-private-auth"
  lambda-bucket  = "${module.akerl-githubauthlambda.publish-bucket}"
  domain         = "auth.scrtybybscrty.org"
}
