module "certificate_validation" {
  for_each    = var.certificates
  source      = "armorfret/r53-certbot/aws"
  version     = "0.7.0"
  admin_email = var.admin_email
  cert_name   = each.key
  zone_id     = module.zones[replace(each.key, local.host_to_zone_regex, "$1")].zone_id
  issue_list  = each.value
}

