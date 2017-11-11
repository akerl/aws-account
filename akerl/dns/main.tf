variable "cloudfront-zone-id" {
  type = "string"
}

variable "blog-dns-name" {
  type = "string"
}

variable "blog-redirect-dns-name" {
  type = "string"
}

variable "repo-dns-name" {
  type = "string"
}

variable "wedding-dns-name" {
  type = "string"
}

variable "madlibrarian-dns-name" {
  type = "string"
}

variable "keys-dns-name" {
  type = "string"
}

resource "aws_route53_delegation_set" "main" {
  reference_name = "main"
}
