terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.56.0"
    }

    awscreds = {
      source  = "armorfret/awscreds"
      version = "0.6.3"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "awscreds" {
  region = "us-east-1"
}
