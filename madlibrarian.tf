module "akerl-hf-library" {
  source         = "armorfret/lambda-madlibrarian/aws"
  version        = "0.0.4"
  logging-bucket = "${module.account.logging-bucket}"
  config-bucket  = "akerl-hf-library-config"
  data-bucket    = "akerl-hf-library"
  lambda-bucket  = "${module.akerl-madlibrarian.publish-bucket}"
  domain         = "hf.coolquotes.xyz"
}

module "akerl-books-library" {
  source         = "armorfret/lambda-madlibrarian/aws"
  version        = "0.0.4"
  logging-bucket = "${module.account.logging-bucket}"
  config-bucket  = "akerl-book-library-config"
  data-bucket    = "akerl-book-library"
  lambda-bucket  = "${module.akerl-madlibrarian.publish-bucket}"
  domain         = "books.coolquotes.xyz"
}

module "akerl-dcs-library" {
  source         = "armorfret/lambda-madlibrarian/aws"
  version        = "0.0.4"
  logging-bucket = "${module.account.logging-bucket}"
  config-bucket  = "akerl-dcs-library-config"
  data-bucket    = "akerl-dcs-library"
  lambda-bucket  = "${module.akerl-madlibrarian.publish-bucket}"
  domain         = "dcs.coolquotes.xyz"
}
