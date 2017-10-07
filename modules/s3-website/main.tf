variable "logging-bucket" {
  type = "string"
}

variable "file-bucket" {
  type = "string"
}

variable "redirect-bucket" {
  type = "string"
}

variable "write-user" {
  type = "string"
}

variable "root-domain" {
  type = "string"
}

variable "redirect-domains" {
  type    = "list"
  default = []
}

variable "no-cache-path" {
  type    = "string"
  default = "_________"
}

output "site-dns-name" {
  value = "${aws_cloudfront_distribution.site_distribution.domain_name}"
}

output "redirect-dns-name" {
  value = "${aws_cloudfront_distribution.redirect_distribution.domain_name}"
}

output "cloudfront-zone-id" {
  value = "${aws_cloudfront_distribution.site_distribution.hosted_zone_id}"
}
