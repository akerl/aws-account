module "aker_family" {
  source            = "armorfret/r53-zone/aws"
  version           = "0.6.0"
  admin_email       = var.admin_email
  domain_name       = "aker.family"
  delegation_set_id = aws_route53_delegation_set.main.id
}

