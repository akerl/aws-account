module "id-ed25519_pub" {
  source            = "armorfret/r53-zone/aws"
  version           = "0.4.0"
  admin_email       = var.admin_email
  domain_name       = "id-ed25519.pub"
  delegation_set_id = aws_route53_delegation_set.main.id
}

resource "aws_route53_record" "a_id-ed25519_pub" {
  zone_id = module.id-ed25519_pub.zone_id
  name    = "id-ed25519.pub"
  type    = "A"

  alias {
    name                   = var.akerl-blog-redirect_dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_id-ed25519_pub" {
  zone_id = module.id-ed25519_pub.zone_id
  name    = "www.id-ed25519.pub"
  type    = "A"

  alias {
    name                   = var.akerl-blog-redirect_dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}
