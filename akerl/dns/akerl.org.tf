module "akerl_org" {
  source            = "armorfret/r53-zone/aws"
  version           = "0.5.0"
  admin_email       = var.admin_email
  domain_name       = "akerl.org"
  delegation_set_id = aws_route53_delegation_set.main.id
}

resource "aws_route53_record" "a_akerl_org" {
  zone_id = module.akerl_org.zone_id
  name    = "akerl.org"
  type    = "A"

  alias {
    name                   = var.akerl-blog-redirect_dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_www_akerl_org" {
  zone_id = module.akerl_org.zone_id
  name    = "www.akerl.org"
  type    = "A"

  alias {
    name                   = var.akerl-blog-redirect_dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_blog_akerl_org" {
  zone_id = module.akerl_org.zone_id
  name    = "blog.akerl.org"
  type    = "A"

  alias {
    name                   = var.akerl-blog-dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_goat_akerl_org" {
  zone_id = module.akerl_org.zone_id
  name    = "goat.akerl.org"
  type    = "A"
  ttl     = "60"
  records = ["170.187.160.67"]
}

module "goat_ext_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.2.0"
  admin_email       = var.admin_email
  delegation_set_id = "goat"
  subzone_name      = "goat.certs.akerl.org"
  cert_name         = "goat.akerl.org"
  parent_zone_id    = module.akerl_org.zone_id
}
