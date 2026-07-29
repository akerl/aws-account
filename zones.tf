locals {
  dmarc_domain = split("@", var.dmarc_email)[1]
}

resource "aws_route53_delegation_set" "main" {
  reference_name = "main"
}

module "zones" {
  source  = "armorfret/r53-zone/aws"
  version = "0.8.5"

  for_each = var.domains

  admin_email       = var.admin_email
  domain_name       = each.key
  delegation_set_id = aws_route53_delegation_set.main.id
  caa_list          = each.key == "kellywatts.com" ? [] : ["amazon.com"]
  dkim_config       = fileexists("dkim/${each.key}") ? trimspace(file("dkim/${each.key}")) : ""
  dmarc_email       = var.dmarc_email
}

resource "aws_route53_record" "dmarc_delegation" {
  for_each = toset([for x in var.domains : x if x != local.dmarc_domain])

  zone_id = module.zones[local.dmarc_domain].zone_id
  name    = "${each.key}._report._dmarc"
  type    = "TXT"
  ttl     = "86400"
  records = ["v=DMARC1;"]
}
