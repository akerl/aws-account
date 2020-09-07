module "akerl_dev" {
  source            = "armorfret/r53-zone/aws"
  version           = "0.3.1"
  admin_email       = var.admin_email
  domain_name       = "akerl.dev"
  delegation_set_id = aws_route53_delegation_set.main.id
}

resource "aws_route53_record" "a_pumidor_akerl_dev" {
  zone_id = module.akerl_dev.zone_id
  name    = "pumidor.akerl.dev"
  type    = "A"
  ttl     = "60"
  records = ["66.228.38.88"]
}

