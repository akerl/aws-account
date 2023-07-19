module "id-ed25519_pub" {
  source            = "armorfret/r53-zone/aws"
  version           = "0.6.0"
  admin_email       = var.admin_email
  domain_name       = "id-ed25519.pub"
  delegation_set_id = aws_route53_delegation_set.main.id
}
