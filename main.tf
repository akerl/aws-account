terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.9.0"
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

variable "admin_email" {
  type    = string
  default = "admin@lesaker.org"
}

resource "aws_route53_delegation_set" "main" {
  reference_name = "main"
}

