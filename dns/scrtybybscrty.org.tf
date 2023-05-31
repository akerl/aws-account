module "scrtybybscrty_org" {
  source            = "armorfret/r53-zone/aws"
  version           = "0.6.0"
  admin_email       = var.admin_email
  domain_name       = "scrtybybscrty.org"
  delegation_set_id = aws_route53_delegation_set.main.id
}

resource "aws_route53_record" "a_scrtybybscrty_org" {
  zone_id = module.scrtybybscrty_org.zone_id
  name    = "scrtybybscrty.org"
  type    = "A"

  alias {
    name                   = var.akerl-blog-redirect_dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_www_scrtybybscrty_org" {
  zone_id = module.scrtybybscrty_org.zone_id
  name    = "www.scrtybybscrty.org"
  type    = "A"

  alias {
    name                   = var.akerl-blog-redirect_dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_littlesnitch_scrtybybscrty_org" {
  zone_id = module.scrtybybscrty_org.zone_id
  name    = "littlesnitch.scrtybybscrty.org"
  type    = "A"

  alias {
    name                   = var.akerl-littlesnitch-dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_auth_scrtybybscrty_org" {
  zone_id = module.scrtybybscrty_org.zone_id
  name    = "auth.scrtybybscrty.org"
  type    = "A"

  alias {
    name                   = var.akerl-private-auth-dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_files_scrtybybscrty_org" {
  zone_id = module.scrtybybscrty_org.zone_id
  name    = "files.scrtybybscrty.org"
  type    = "A"

  alias {
    name                   = var.akerl-private-files-dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}
