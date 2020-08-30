module "akerl-blog" {
  source           = "armorfret/s3-website/aws"
  version          = "0.3.3"
  logging_bucket   = module.account.logging_bucket
  file_bucket      = "akerl-blog"
  redirect_bucket  = "akerl-blog-redirect"
  primary_hostname = "blog.akerl.org"
  error_document   = "404/index.html"

  redirect_hostnames = [
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
  source           = "armorfret/s3-website/aws"
  version          = "0.3.3"
  file_bucket      = "akerl-keys"
  redirect_bucket  = "akerl-keys-redirect"
  primary_hostname = "id-ed25519.pub"
  error_document   = "404.html"
  logging_bucket   = module.account.logging_bucket
}

module "akerl-scratch" {
  source           = "armorfret/s3-website/aws"
  version          = "0.3.3"
  logging_bucket   = module.account.logging_bucket
  file_bucket      = "akerl-scratch"
  redirect_bucket  = "akerl-scratch-redirect"
  primary_hostname = "scratch.scrtybybscrty.org"
  error_document   = "404.html"
}

module "akerl-littlesnitch-rules" {
  source           = "armorfret/s3-website/aws"
  version          = "0.3.3"
  file_bucket      = "akerl-littlesnitch-rules"
  redirect_bucket  = "akerl-littlesnitch-rules-redirect"
  primary_hostname = "littlesnitch.scrtybybscrty.org"
  error_document   = "404.html"
  logging_bucket   = module.account.logging_bucket
}

module "amylum-repo" {
  source           = "armorfret/s3-website/aws"
  version          = "0.3.3"
  logging_bucket   = module.account.logging_bucket
  file_bucket      = "amylum-repo"
  redirect_bucket  = "amylum-repo-redirect"
  primary_hostname = "repo.scrtybybscrty.org"
}

