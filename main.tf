provider "aws" {
  region   = "us-east-1"
  insecure = "true"
}

provider "awscreds" {
  region   = "us-east-1"
  insecure = "true"
}

module "account" {
  source = "./account"
  prefix = "akerl"
  admins = ["akerl"]
}

module "akerl-dns" {
  source         = "./akerl/dns"
  logging-bucket = "${module.account.logging-bucket}"
}

module "akerl-blog" {
  source         = "./akerl/blog"
  logging-bucket = "${module.account.logging-bucket}"
}

module "akerl-aws-account" {
  source = "./akerl/aws-account"
}
