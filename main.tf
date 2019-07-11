provider "aws" {
  version = "2.18.0"
  region  = "us-east-1"
}

provider "awscreds" {
  // provider.awscreds armorfret/terraform-provider-awscreds
  version = "0.2.0"
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
  cloudfront_zone_id                = module.akerl-blog.cloudfront_zone_id
  akerl-blog-dns_name               = module.akerl-blog.site_dns_name
  akerl-blog-redirect_dns_name      = module.akerl-blog.redirect_dns_name
  akerl-keys-dns_name               = module.akerl-keys.site_dns_name
  akerl-scratch-dns_name            = module.akerl-scratch.site_dns_name
  akerl-littlesnitch-rules-dns_name = module.akerl-littlesnitch-rules.site_dns_name
  amylum-repo-dns_name              = module.amylum-repo.site_dns_name
  akerl-wedding-dns_name            = module.akerl-wedding.wedding-dns_name
  akerl-hf-library-dns_name         = module.akerl-hf-library.dns_name
  akerl-books-library-dns_name      = module.akerl-books-library.dns_name
  akerl-dcs-library-dns_name        = module.akerl-dcs-library.dns_name
  akerl-quote-auth-dns_name         = module.akerl-quote-auth.dns_name
  akerl-private-files-dns_name      = module.akerl-private-files.dns_name
  akerl-private-auth-dns_name       = module.akerl-private-auth.dns_name
  akerl-coolquotes-share-dns_name   = module.akerl-coolquotes-share.dns_name
}

module "akerl-wedding" {
  source         = "./akerl/wedding"
  logging_bucket = module.account.logging_bucket
}

module "akerl-aws-account" {
  source = "./akerl/aws-account"
}

