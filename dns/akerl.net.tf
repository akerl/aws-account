module "akerl_net" {
  source            = "armorfret/r53-zone/aws"
  version           = "0.6.0"
  admin_email       = var.admin_email
  domain_name       = "akerl.net"
  delegation_set_id = aws_route53_delegation_set.main.id
}

resource "aws_route53_record" "a_akerl_net" {
  zone_id = module.akerl_net.zone_id
  name    = "akerl.net"
  type    = "A"

  alias {
    name                   = var.akerl-blog-redirect_dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_www_akerl_net" {
  zone_id = module.akerl_net.zone_id
  name    = "www.akerl.net"
  type    = "A"

  alias {
    name                   = var.akerl-blog-redirect_dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}
