variable "logging-bucket" {
  type = "string"
}

variable "config-bucket" {
  type = "string"
}

variable "data-bucket" {
  type = "string"
}

variable "lambda-bucket" {
  type = "string"
}

variable "domain" {
  type = "string"
}

output "dns-name" {
  value = "${aws_api_gateway_domain_name.domain.cloudfront_domain_name}"
}

module "certificate" {
  source    = "github.com/akerl/terraform-aws-acm-certificate"
  hostnames = ["${var.domain}"]
}
