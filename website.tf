module "akerl-blog" {
  source           = "armorfret/s3-website/aws"
  version          = "0.8.7"
  logging_bucket   = aws_s3_bucket.logging.id
  file_bucket      = "akerl-blog"
  redirect_bucket  = "akerl-blog-redirect"
  primary_hostname = "blog.akerl.org"
  error_document   = "404/index.html"

  content_security_policy = "frame-ancestors 'none'; default-src 'none'; img-src 'self' goat.akerl.org; script-src 'self' 'unsafe-inline' https://goat.akerl.org https://gist.github.com; style-src 'self' 'unsafe-inline' https://github.githubassets.com; object-src 'none'; connect-src"

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
  version          = "0.8.7"
  logging_bucket   = aws_s3_bucket.logging.id
  file_bucket      = "amylum-repo"
  redirect_bucket  = "amylum-repo-redirect"
  primary_hostname = "repo.scrtybybscrty.org"
}

module "akerl-littlesnitch" {
  source           = "armorfret/s3-website/aws"
  version          = "0.8.7"
  logging_bucket   = aws_s3_bucket.logging.id
  file_bucket      = "akerl-littlesnitch"
  redirect_bucket  = "akerl-littlesnitch-redirect"
  primary_hostname = "littlesnitch.scrtybybscrty.org"
}
