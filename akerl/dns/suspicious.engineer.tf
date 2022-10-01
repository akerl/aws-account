module "suspicious_engineer" {
  source            = "armorfret/r53-zone/aws"
  version           = "0.5.0"
  admin_email       = var.admin_email
  domain_name       = "suspicious.engineer"
  delegation_set_id = aws_route53_delegation_set.main.id
}

