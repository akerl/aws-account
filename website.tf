module "akerl-blog" {
  source           = "armorfret/s3-website/aws"
  version          = "0.4.7"
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
    "id-ed25519.pub",
    "www.id-ed25519.pub",
    "akerl.dev",
    "www.akerl.dev",
  ]
}

module "amylum-repo" {
  source           = "armorfret/s3-website/aws"
  version          = "0.4.7"
  logging_bucket   = module.account.logging_bucket
  file_bucket      = "amylum-repo"
  redirect_bucket  = "amylum-repo-redirect"
  primary_hostname = "repo.scrtybybscrty.org"
}

