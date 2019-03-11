module "akerl-hf-library" {
  source         = "armorfret/lambda-madlibrarian/aws"
  version        = "0.0.8"
  logging_bucket = "${module.account.logging_bucket}"
  config_bucket  = "akerl-hf-library-config"
  data_bucket    = "akerl-hf-library"
  lambda_bucket  = "${module.akerl-madlibrarian.publish_bucket}"
  hostname       = "hf.coolquotes.xyz"
}

module "akerl-books-library" {
  source         = "armorfret/lambda-madlibrarian/aws"
  version        = "0.0.8"
  logging_bucket = "${module.account.logging_bucket}"
  config_bucket  = "akerl-book-library-config"
  data_bucket    = "akerl-book-library"
  lambda_bucket  = "${module.akerl-madlibrarian.publish_bucket}"
  hostname       = "books.coolquotes.xyz"
}

module "akerl-dcs-library" {
  source         = "armorfret/lambda-madlibrarian/aws"
  version        = "0.0.8"
  logging_bucket = "${module.account.logging_bucket}"
  config_bucket  = "akerl-dcs-library-config"
  data_bucket    = "akerl-dcs-library"
  lambda_bucket  = "${module.akerl-madlibrarian.publish_bucket}"
  hostname       = "dcs.coolquotes.xyz"
}
