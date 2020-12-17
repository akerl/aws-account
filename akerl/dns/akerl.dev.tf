module "akerl_dev" {
  source            = "armorfret/r53-zone/aws"
  version           = "0.3.2"
  admin_email       = var.admin_email
  domain_name       = "akerl.dev"
  delegation_set_id = aws_route53_delegation_set.main.id
}

resource "aws_route53_record" "pumidor_temp_record" {
  zone_id = module.akerl_dev.zone_id
  name    = "pumidor.akerl.dev"
  type    = "A"
  ttl     = "60"
  records = ["162.216.18.19"]
}

