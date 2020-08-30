module "akerl_com" {
  source            = "armorfret/r53-zone/aws"
  version           = "0.3.1"
  admin_email       = var.admin_email
  domain_name       = "akerl.com"
  delegation_set_id = aws_route53_delegation_set.main.id
}

resource "aws_route53_record" "a_akerl_com" {
  zone_id = module.akerl_com.zone_id
  name    = "akerl.com"
  type    = "A"

  alias {
    name                   = var.akerl-blog-redirect_dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_www_akerl_com" {
  zone_id = module.akerl_com.zone_id
  name    = "www.akerl.com"
  type    = "A"

  alias {
    name                   = var.akerl-blog-redirect_dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

