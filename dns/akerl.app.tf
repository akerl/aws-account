module "akerl_app" {
  source            = "armorfret/r53-zone/aws"
  version           = "0.6.0"
  admin_email       = var.admin_email
  domain_name       = "akerl.app"
  delegation_set_id = aws_route53_delegation_set.main.id
}

resource "aws_route53_record" "a_akerl_app" {
  zone_id = module.akerl_app.zone_id
  name    = "akerl.app"
  type    = "A"

  alias {
    name                   = var.akerl-blog-redirect_dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_www_akerl_app" {
  zone_id = module.akerl_app.zone_id
  name    = "www.akerl.app"
  type    = "A"

  alias {
    name                   = var.akerl-blog-redirect_dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_goat_akerl_app" {
  zone_id = module.akerl_app.zone_id
  name    = "goat.akerl.app"
  type    = "A"
  ttl     = "60"
  records = ["170.187.160.67"]
}

module "goat_ext_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.5.0"
  admin_email       = var.admin_email
  delegation_set_id = "goat"
  subzone_name      = "goat.certs.akerl.app"
  cert_name         = "goat.akerl.app"
  parent_zone_id    = module.akerl_app.zone_id
}

resource "aws_route53_record" "a_watchdog_akerl_app" {
  zone_id = module.akerl_app.zone_id

  name = "watchdog.akerl.app"
  type = "A"

  alias {
    name                   = var.akerl-watchdog-site-dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}
