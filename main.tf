provider "aws" {
  version = "1.24.0"
  region  = "us-east-1"
}

provider "awscreds" {
  version = "0.5.0"
  region  = "us-east-1"
}

module "account" {
  source = "./account"

  admins = [
    "akerl-bean",
    "akerl-mazer",
  ]
}

module "akerl-dns" {
  source                       = "./akerl/dns"
  cloudfront-zone-id           = "${module.akerl-blog.cloudfront-zone-id}"
  akerl-blog-dns-name          = "${module.akerl-blog.site-dns-name}"
  akerl-blog-redirect-dns-name = "${module.akerl-blog.redirect-dns-name}"
  akerl-keys-dns-name          = "${module.akerl-keys.site-dns-name}"
  amylum-repo-dns-name         = "${module.amylum-repo.site-dns-name}"
  akerl-wedding-dns-name       = "${module.akerl-wedding.wedding-dns-name}"
  akerl-hf-library-dns-name    = "${module.akerl-hf-library.dns-name}"
  akerl-dcs-library-dns-name   = "${module.akerl-dcs-library.dns-name}"
  akerl-quote-auth-dns-name    = "${module.akerl-quote-auth.dns-name}"
}

module "akerl-blog" {
  source         = "./akerl/blog"
  logging-bucket = "${module.account.logging-bucket}"
}

module "akerl-keys" {
  source         = "./akerl/keys"
  logging-bucket = "${module.account.logging-bucket}"
}

module "akerl-hookshot" {
  source         = "./akerl/hookshot"
  logging-bucket = "${module.account.logging-bucket}"
}

module "akerl-sns-to-slack" {
  source         = "./akerl/sns-to-slack"
  logging-bucket = "${module.account.logging-bucket}"
}

module "akerl-madlibrarian" {
  source         = "./akerl/madlibrarian"
  logging-bucket = "${module.account.logging-bucket}"
}

module "akerl-github-auth-lambda" {
  source         = "./akerl/github-auth-lambda"
  logging-bucket = "${module.account.logging-bucket}"
}

module "akerl-quote-auth" {
  source         = "./akerl/quote-auth"
  logging-bucket = "${module.account.logging-bucket}"
  lambda-bucket  = "${module.akerl-github-auth-lambda.lambda-bucket}"
}

module "akerl-hf-library" {
  source         = "./akerl/hf-library"
  logging-bucket = "${module.account.logging-bucket}"
  lambda-bucket  = "${module.akerl-madlibrarian.lambda-bucket}"
}

module "akerl-dcs-library" {
  source         = "./akerl/dcs-library"
  logging-bucket = "${module.account.logging-bucket}"
  lambda-bucket  = "${module.akerl-madlibrarian.lambda-bucket}"
}

module "akerl-wedding" {
  source         = "./akerl/wedding"
  logging-bucket = "${module.account.logging-bucket}"
}

module "akerl-aws-account" {
  source = "./akerl/aws-account"
}

module "amylum-repo" {
  source         = "./amylum/repo"
  logging-bucket = "${module.account.logging-bucket}"
}

module "dock0-arch" {
  source         = "./dock0/arch"
  logging-bucket = "${module.account.logging-bucket}"
}
