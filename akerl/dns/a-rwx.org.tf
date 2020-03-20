module "a-rwx_org" {
  source            = "armorfret/r53-zone/aws"
  version           = "0.1.0"
  admin_email       = var.admin_email
  domain_name       = "a-rwx.org"
  delegation_set_id = aws_route53_delegation_set.main.id
}

resource "aws_route53_record" "a_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "a-rwx.org"
  type    = "A"

  alias {
    name                   = var.akerl-blog-redirect_dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_www_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "www.a-rwx.org"
  type    = "A"

  alias {
    name                   = var.akerl-blog-redirect_dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "gateway_infra_home_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "gateway.infra.home.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["10.0.0.1"]
}

resource "aws_route53_record" "core_infra_home_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "core.infra.home.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["10.0.0.2"]
}

resource "aws_route53_record" "controller_infra_home_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "controller.infra.home.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["10.0.0.10"]
}

resource "aws_route53_record" "switch0_infra_home_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "switch0.infra.home.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["10.0.0.20"]
}

resource "aws_route53_record" "switch1_infra_home_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "switch1.infra.home.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["10.0.0.21"]
}

resource "aws_route53_record" "switch2_infra_home_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "switch2.infra.home.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["10.0.0.22"]
}

resource "aws_route53_record" "wap0_infra_home_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "wap0.infra.home.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["10.0.0.40"]
}

resource "aws_route53_record" "wap1_infra_home_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "wap1.infra.home.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["10.0.0.41"]
}

resource "aws_route53_record" "wap2_infra_home_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "wap2.infra.home.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["10.0.0.42"]
}
