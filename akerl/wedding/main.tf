variable "logging_bucket" {
  type = "string"
}

variable "redirect_bucket" {
  type    = "string"
  default = "akerl-wedding-redirect"
}

output "wedding-dns_name" {
  value = "${aws_cloudfront_distribution.redirect_distribution.domain_name}"
}
