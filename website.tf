module "akerl-blog" {
  source          = "armorfret/s3-website/aws"
  version         = "0.0.3"
  logging-bucket  = "${module.account.logging-bucket}"
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
  ]
}

module "akerl-keys" {
  source          = "armorfret/s3-website/aws"
  version         = "0.0.3"
  logging-bucket  = "${var.logging-bucket}"
  file-bucket     = "akerl-keys"
  redirect-bucket = "akerl-keys-redirect"
  root-domain     = "id-ed25519.pub"
  error-document  = "404.html"
  logging-bucket  = "${module.account.logging-bucket}"
}

module "akerl-scratch" {
  source          = "armorfret/s3-website/aws"
  version         = "0.0.3"
  logging-bucket  = "${module.account.logging-bucket}"
  file-bucket     = "akerl-scratch"
  redirect-bucket = "akerl-scratch-redirect"
  root-domain     = "scratch.scrtybybscrty.org"
  error-document  = "404.html"
}

module "akerl-littlesnitch-rules" {
  source          = "armorfret/s3-website/aws"
  version         = "0.0.3"
  file-bucket     = "akerl-littlesnitch-rules"
  redirect-bucket = "akerl-littlesnitch-rules-redirect"
  root-domain     = "littlesnitch.scrtybybscrty.org"
  error-document  = "404.html"
  logging-bucket  = "${module.account.logging-bucket}"
}

module "amylum-repo" {
  source          = "armorfret/s3-website/aws"
  version         = "0.0.3"
  logging-bucket  = "${module.account.logging-bucket}"
  file-bucket     = "amylum-repo"
  redirect-bucket = "amylum-repo-redirect"
  root-domain     = "repo.scrtybybscrty.org"
}
