module "s3-website" {
  source          = "../../modules/s3-website"
  logging-bucket  = "${var.logging-bucket}"
  file-bucket     = "akerl-keys"
  redirect-bucket = "akerl-keys-redirect"
  root-domain     = "id-ed25519.pub"
  error-document  = "404.html"
}

variable "logging-bucket" {
  type = "string"
}

output "site-dns-name" {
  value = "${module.s3-website.site-dns-name}"
}
