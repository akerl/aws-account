variable "logging-bucket" {
  type = "string"
}

variable "redirect-bucket" {
  type    = "string"
  default = "akerl-wedding-redirect"
}

output "wedding-dns-name" {
  value = "${aws_cloudfront_distribution.redirect_distribution.domain_name}"
}
