provider "aws" {
    region = "us-east-1"
}

provider "awscreds" {
    region = "us-east-1"
}

module "account" {
    source = "./account"
    prefix = "akerl"
    admins = ["akerl", "flula"]
}

