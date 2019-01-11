module "s3-website" {
  source          = "github.com/armorfret/terraform-aws-s3-website"
  logging-bucket  = "${var.logging-bucket}"
  file-bucket     = "akerl-scratch"
  redirect-bucket = "akerl-scratch-redirect"
  root-domain     = "scratch.scrtybybscrty.org"
  error-document  = "404.html"
}

variable "logging-bucket" {
  type = "string"
}

output "site-dns-name" {
  value = "${module.s3-website.site-dns-name}"
}
