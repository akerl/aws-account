provider "aws" {
    region = "us-east-1"
}

resource "aws_route53_delegation_set" "main" {
    reference_name = "main"
}
