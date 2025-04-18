locals {
  blog_redirects = [
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

  host_to_zone_regex = "/^(?:.*\\.)?([^.]+\\.[^.]+)$/"
}

module "akerl-blog" {
  source           = "armorfret/s3-website/aws"
  version          = "0.11.4"
  logging_bucket   = aws_s3_bucket.logging.id
  file_bucket      = "akerl-blog"
  redirect_bucket  = "akerl-blog-redirect"
  primary_hostname = "blog.akerl.org"
  error_document   = "404/index.html"

  content_security_policy = "frame-ancestors 'none'; default-src 'none'; img-src 'self' goat.akerl.app; script-src 'self' https://goat.akerl.app https://gist.github.com; style-src 'self' 'unsafe-inline' https://github.githubassets.com; object-src 'none'; connect-src https://goat.akerl.app/count; require-trusted-types-for 'script'"

  redirect_hostnames = local.blog_redirects
}

resource "aws_route53_record" "a_blog_akerl_org" {
  zone_id = module.zones["akerl.org"].zone_id
  name    = "blog.akerl.org"
  type    = "A"

  alias {
    name                   = module.akerl-blog.site_dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "blog_redirect" {
  for_each = toset(local.blog_redirects)

  zone_id = module.zones[replace(each.key, local.host_to_zone_regex, "$1")].zone_id
  name    = each.key
  type    = "A"

  alias {
    name                   = module.akerl-blog.redirect_dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}

module "akerl-littlesnitch" {
  source           = "armorfret/s3-website/aws"
  version          = "0.11.4"
  logging_bucket   = aws_s3_bucket.logging.id
  file_bucket      = "akerl-littlesnitch"
  redirect_bucket  = "akerl-littlesnitch-redirect"
  primary_hostname = "littlesnitch.scrtybybscrty.org"
}

resource "aws_route53_record" "a_littlesnitch_scrtybybscrty_org" {
  zone_id = module.zones["scrtybybscrty.org"].zone_id
  name    = "littlesnitch.scrtybybscrty.org"
  type    = "A"

  alias {
    name                   = module.akerl-littlesnitch.site_dns_name
    zone_id                = module.akerl-littlesnitch.cloudfront_zone_id
    evaluate_target_health = false
  }
}

module "amylum-repo" {
  source           = "armorfret/s3-website/aws"
  version          = "0.11.4"
  logging_bucket   = aws_s3_bucket.logging.id
  file_bucket      = "amylum-repo"
  redirect_bucket  = "amylum-repo-redirect"
  primary_hostname = "repo.scrtybybscrty.org"
}

resource "aws_route53_record" "a_repo_scrtybybscrty_org" {
  zone_id = module.zones["scrtybybscrty.org"].zone_id
  name    = "repo.scrtybybscrty.org"
  type    = "A"

  alias {
    name                   = module.amylum-repo.site_dns_name
    zone_id                = module.amylum-repo.cloudfront_zone_id
    evaluate_target_health = false
  }
}
