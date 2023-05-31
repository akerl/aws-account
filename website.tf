module "akerl-blog" {
  source           = "armorfret/s3-website/aws"
  version          = "0.10.0"
  logging_bucket   = aws_s3_bucket.logging.id
  file_bucket      = "akerl-blog"
  redirect_bucket  = "akerl-blog-redirect"
  primary_hostname = "blog.akerl.org"
  error_document   = "404/index.html"

  content_security_policy = "frame-ancestors 'none'; default-src 'none'; img-src 'self' goat.akerl.app; script-src 'self' 'unsafe-inline' https://goat.akerl.app https://gist.github.com; style-src 'self' 'unsafe-inline' https://github.githubassets.com; object-src 'none'; connect-src"

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
    "akerl.dev",
    "www.akerl.dev",
    "akerl.app",
    "www.akerl.app",
    "akerl.net",
    "www.akerl.net",
  ]
}

module "akerl-littlesnitch" {
  source           = "armorfret/s3-website/aws"
  version          = "0.10.0"
  logging_bucket   = aws_s3_bucket.logging.id
  file_bucket      = "akerl-littlesnitch"
  redirect_bucket  = "akerl-littlesnitch-redirect"
  primary_hostname = "littlesnitch.scrtybybscrty.org"
}
