locals {
  ignore_domains = [
    "sophieaker.com",
    "claireaker.com",
    "akerl.app",
  ]
}

resource "aws_route53_delegation_set" "main" {
  reference_name = "main"
}

module "zones" {
  source  = "armorfret/r53-zone/aws"
  version = "0.6.2"

  for_each = var.domains

  admin_email       = var.admin_email
  domain_name       = each.key
  delegation_set_id = aws_route53_delegation_set.main.id
  caa_list          = each.key == "kellywatts.com" ? [] : ["amazon.com"]
}

#resource "aws_route53domains_registered_domain" "this" {
#  for_each = toset([for x in var.domains : x if !contains(local.ignore_domains, x)])
#
#  domain_name = each.key
#
#  dynamic "name_server" {
#    for_each = aws_route53_delegation_set.main.name_servers
#
#    content {
#      name = name_server.value
#    }
#  }
#}
