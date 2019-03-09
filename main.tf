provider "aws" {
  version = "2.1.0"
  region  = "us-east-1"
}

provider "awscreds" {
  // provider.awscreds armorfret/terraform-provider-awscreds
  version = "0.1.1"
  region  = "us-east-1"
}

module "account" {
  source = "./account"

  admins = [
    "akerl-bean",
    "akerl-mazer",
    "akerl-codepad",
  ]
}

module "akerl-dns" {
  source                            = "./akerl/dns"
  admin_email                       = "admin@lesaker.org"
  cloudfront-zone-id                = "${module.akerl-blog.cloudfront-zone-id}"
  akerl-blog-dns-name               = "${module.akerl-blog.site-dns-name}"
  akerl-blog-redirect-dns-name      = "${module.akerl-blog.redirect-dns-name}"
  akerl-keys-dns-name               = "${module.akerl-keys.site-dns-name}"
  akerl-scratch-dns-name            = "${module.akerl-scratch.site-dns-name}"
  akerl-littlesnitch-rules-dns-name = "${module.akerl-littlesnitch-rules.site-dns-name}"
  amylum-repo-dns-name              = "${module.amylum-repo.site-dns-name}"
  akerl-wedding-dns-name            = "${module.akerl-wedding.wedding-dns-name}"
  akerl-hf-library-dns-name         = "${module.akerl-hf-library.dns-name}"
  akerl-books-library-dns-name      = "${module.akerl-books-library.dns-name}"
  akerl-dcs-library-dns-name        = "${module.akerl-dcs-library.dns-name}"
  akerl-quote-auth-dns-name         = "${module.akerl-quote-auth.dns-name}"
  akerl-private-files-dns-name      = "${module.akerl-private-files.dns-name}"
  akerl-private-auth-dns-name       = "${module.akerl-private-auth.dns-name}"
}

module "akerl-wedding" {
  source         = "./akerl/wedding"
  logging-bucket = "${module.account.logging-bucket}"
}

module "akerl-aws-account" {
  source = "./akerl/aws-account"
}
