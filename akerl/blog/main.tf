module "s3-website" {
  source          = "../../modules/s3-website"
  logging-bucket  = "${var.logging-bucket}"
  file-bucket     = "akerl-blog"
  redirect-bucket = "akerl-blog-redirect"
  root-domain     = "blog.akerl.org"
  error-document  = "404/index.html"

  redirect-domains = [
    "lesaker.org",
    "www.lesaker.org",
    "scrtybybscrty.org",
    "www.scrtybybscrty.org",
    "lesaker.com",
    "www.lesaker.com",
    "akerl.org",
    "www.akerl.org",
    "akerl.com",
    "www.akerl.com",
    "a-rwx.org",
    "www.a-rwx.org",
    "id-ed25519.pub",
    "www.id-ed25519.pub",
  ]
}

variable "logging-bucket" {
  type = "string"
}

output "cloudfront-zone-id" {
  value = "${module.s3-website.cloudfront-zone-id}"
}

output "site-dns-name" {
  value = "${module.s3-website.site-dns-name}"
}

output "redirect-dns-name" {
  value = "${module.s3-website.redirect-dns-name}"
}
