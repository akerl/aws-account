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
    name                   = module.akerl-blog.redirect_dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_www_akerl_app" {
  zone_id = module.akerl_app.zone_id
  name    = "www.akerl.app"
  type    = "A"

  alias {
    name                   = module.akerl-blog.redirect_dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
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
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.2"
  admin_email = var.admin_email
  cert_name   = "goat.akerl.app"
  zone_id     = module.akerl_app.zone_id
}

resource "aws_route53_record" "a_charts_akerl_app" {
  zone_id = module.akerl_app.zone_id
  name    = "charts.akerl.app"
  type    = "A"
  ttl     = "60"
  records = ["143.42.119.89"]
}

module "charts_ext_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.2"
  admin_email = var.admin_email
  cert_name   = "charts.akerl.app"
  zone_id     = module.akerl_app.zone_id
}

resource "aws_route53_record" "a_watchdog_akerl_app" {
  zone_id = module.akerl_app.zone_id

  name = "watchdog.akerl.app"
  type = "A"

  alias {
    name                   = module.akerl-watchdog-site.dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_poker_akerl_app" {
  zone_id = module.akerl_app.zone_id
  name    = "poker.akerl.app"
  type    = "A"

  alias {
    name                   = module.akerl-blindclock-site.dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_frame_akerl_app" {
  zone_id = module.akerl_app.zone_id
  name    = "frame.akerl.app"
  type    = "A"

  alias {
    name                   = module.akerl-frame-site.dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_exporter_akerl_app" {
  zone_id = module.akerl_app.zone_id
  name    = "exporter.akerl.app"
  type    = "A"

  alias {
    name                   = module.akerl-hook-site.dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}
