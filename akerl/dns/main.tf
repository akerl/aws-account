variable "admin_email" {
  type = string
}

variable "cloudfront_zone_id" {
  type = string
}

variable "akerl-blog-dns_name" {
  type = string
}

variable "akerl-blog-redirect_dns_name" {
  type = string
}

variable "amylum-repo-dns_name" {
  type = string
}

variable "akerl-wedding-dns_name" {
  type = string
}

variable "akerl-dcs-library-dns_name" {
  type = string
}

variable "akerl-hf-library-dns_name" {
  type = string
}

variable "akerl-books-library-dns_name" {
  type = string
}

variable "akerl-quote-auth-dns_name" {
  type = string
}

variable "akerl-private-auth-dns_name" {
  type = string
}

variable "akerl-private-files-dns_name" {
  type = string
}

variable "akerl-coolquotes-share-dns_name" {
  type = string
}

resource "aws_route53_delegation_set" "main" {
  reference_name = "main"
}

