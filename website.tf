locals {
  blog_redirects = [
    "lesaker.org",
    "www.lesaker.org",
    "lesaker.com",
    "www.lesaker.com",
    "akerl.org",
    "www.akerl.org",
    "akerl.com",
    "www.akerl.com",
  ]

  blog_csp = [
    "frame-ancestors 'none';",
    "default-src 'none';",
    "img-src 'self' goat.akerl.org;",
    "script-src 'self' 'unsafe-inline' https://goat.akerl.org;",
    "style-src 'self' 'unsafe-inline';",
    "object-src 'none';",
    "connect-src https://goat.akerl.org/count;",
  ]

  host_to_zone_regex = "/^(?:.*\\.)?([^.]+\\.[^.]+)$/"
}

module "akerl-blog" {
  source                  = "armorfret/s3-website/aws"
  version                 = "0.11.6"
  logging_bucket          = aws_s3_bucket.logging.id
  file_bucket             = "akerl-blog"
  redirect_bucket         = "akerl-blog-redirect"
  primary_hostname        = "blog.akerl.org"
  error_document          = "404/index.html"
  content_security_policy = join(" ", local.blog_csp)
  redirect_hostnames      = local.blog_redirects
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
