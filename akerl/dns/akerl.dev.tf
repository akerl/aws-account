module "akerl_dev" {
  source            = "armorfret/r53-zone/aws"
  version           = "0.3.1"
  admin_email       = var.admin_email
  domain_name       = "akerl.dev"
  delegation_set_id = aws_route53_delegation_set.main.id
}

