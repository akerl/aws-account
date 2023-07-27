resource "aws_route53_delegation_set" "main" {
  reference_name = "main"
}

module "zones" {
  source  = "armorfret/r53-zone/aws"
  version = "0.6.0"

  for_each = var.domains

  admin_email       = var.admin_email
  domain_name       = each.key
  delegation_set_id = aws_route53_delegation_set.main.id
  caa_list          = each.key == "kellywatts.com" ? [] : ["amazon.com"]
}
