provider "aws" {
  region = "us-east-1"
}

provider "awscreds" {
  region = "us-east-1"
}

module "account" {
  source = "./account"
  prefix = "akerl"
  admins = ["akerl"]
}

module "akerl-dns" {
  source                 = "./akerl/dns"
  cloudfront-zone-id     = "${module.akerl-blog.cloudfront-zone-id}"
  blog-dns-name          = "${module.akerl-blog.site-dns-name}"
  blog-redirect-dns-name = "${module.akerl-blog.redirect-dns-name}"
  repo-dns-name          = "${module.amylum-repo.site-dns-name}"
  wedding-dns-name       = "${module.akerl-wedding.wedding-dns-name}"
  madlibrarian-dns-name  = "${module.akerl-madlibrarian.madlibrarian-dns-name}"
}

module "akerl-blog" {
  source         = "./akerl/blog"
  logging-bucket = "${module.account.logging-bucket}"
}

module "akerl-madlibrarian" {
  source         = "./akerl/madlibrarian"
  logging-bucket = "${module.account.logging-bucket}"
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
