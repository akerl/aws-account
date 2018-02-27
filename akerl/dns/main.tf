variable "cloudfront-zone-id" {
  type = "string"
}

variable "akerl-blog-dns-name" {
  type = "string"
}

variable "akerl-blog-redirect-dns-name" {
  type = "string"
}

variable "amylum-repo-dns-name" {
  type = "string"
}

variable "akerl-wedding-dns-name" {
  type = "string"
}

variable "akerl-hf-library-dns-name" {
  type = "string"
}

variable "akerl-keys-dns-name" {
  type = "string"
}

resource "aws_route53_delegation_set" "main" {
  reference_name = "main"
}
