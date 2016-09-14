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
    source = "./akerl/dns"
}

module "akerl-blog" {
    source = "./akerl/blog"
    logging-bucket = "${module.account.logging-bucket}"
}
