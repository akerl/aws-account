variable "logging-bucket" {
  type = "string"
}

variable "lambda-bucket" {
  type = "string"
}

variable "data-bucket" {
  type = "string"
}

variable "domain" {
  type = "string"
}

output "dns-name" {
  value = "${aws_api_gateway_domain_name.domain.cloudfront_domain_name}"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

module "certificate" {
  source  = "../../modules/certificate"
  domains = ["${var.domain}"]
}
