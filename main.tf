terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.88.0"
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
    "akerl-hafte",
  ]
}

variable "billing_email" {
  type    = string
  default = "me@lesaker.org"
}

variable "admin_email" {
  type    = string
  default = "admin@lesaker.org"
}

variable "domains" {
  type = set(string)
  default = [
    "a-rwx.org",
    "aker.family",
    "akerl.app",
    "akerl.com",
    "akerl.dev",
    "akerl.net",
    "akerl.org",
    "aliceaker.com",
    "carolineaker.com",
    "coolquotes.xyz",
    "happilyeveraker.com",
    "id-ed25519.pub",
    "kellywatts.com",
    "lesaker.com",
    "lesaker.org",
    "scrtybybscrty.org",
  ]
}

data "terraform_remote_state" "linode" {
  backend = "http"
  config = {
    address = "https://raw.githubusercontent.com/akerl/linode-account/main/terraform.tfstate"
  }
}

data "terraform_remote_state" "unifi" {
  backend = "http"
  config = {
    address = "https://raw.githubusercontent.com/akerl/unifi-site/main/terraform.tfstate"
  }
}

output "domains" {
  value = var.domains
}

output "nameservers" {
  value = aws_route53_delegation_set.main.name_servers
}
