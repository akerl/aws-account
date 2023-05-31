terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.0.1"
    }

    awscreds = {
      source  = "armorfret/awscreds"
      version = "0.6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "awscreds" {
  region = "us-east-1"
}

variable "admins" {
  type = list(string)
  default = [
    "akerl-codepad",
    "akerl-wilson",
  ]
}

variable "billing_email" {
  type    = string
  default = "me@lesaker.org"
}

module "akerl-dns" {
  source                          = "./dns"
  admin_email                     = "admin@lesaker.org"
  cloudfront_zone_id              = module.akerl-blog.cloudfront_zone_id
  akerl-blog-dns_name             = module.akerl-blog.site_dns_name
  akerl-blog-redirect_dns_name    = module.akerl-blog.redirect_dns_name
  akerl-littlesnitch-dns_name     = module.akerl-littlesnitch.site_dns_name
  akerl-wedding-dns_name          = aws_cloudfront_distribution.wedding_redirect_distribution.domain_name
  akerl-hf-library-dns_name       = module.akerl-hf-library.dns_name
  akerl-books-library-dns_name    = module.akerl-books-library.dns_name
  akerl-dcs-library-dns_name      = module.akerl-dcs-library.dns_name
  akerl-quote-auth-dns_name       = module.akerl-quote-auth.dns_name
  akerl-private-files-dns_name    = module.akerl-private-files.dns_name
  akerl-private-auth-dns_name     = module.akerl-private-auth.dns_name
  akerl-coolquotes-share-dns_name = module.akerl-coolquotes-share.dns_name
  akerl-watchdog-site-dns_name    = module.akerl-watchdog-site.dns_name
  akerl-blindclock-site-dns_name  = module.akerl-blindclock-site.dns_name
}
