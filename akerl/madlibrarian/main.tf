variable "logging-bucket" {
  type = "string"
}

variable "data-bucket" {
  type    = "string"
  default = "akerl-madlibrarian"
}

variable "domain" {
  type    = "string"
  default = "coolquotes.xyz"
}

output "madlibrarian-dns-name" {
  value = "${aws_api_gateway_domain_name.domain.cloudfront_domain_name}"
}
