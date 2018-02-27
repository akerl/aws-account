variable "logging-bucket" {
  type = "string"
}

variable "data-bucket" {
  type    = "string"
}

variable "lambda-bucket" {
  type = "string"
}

variable "domain" {
  type    = "string"
}

variable "slack-token" {
  type = "string"
  default = "skip"
}

output "dns-name" {
  value = "${aws_api_gateway_domain_name.domain.cloudfront_domain_name}"
}

module "certificate" {
  source = "../../modules/certificate"
  domains = ["${var.domain}"]
}

