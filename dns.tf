resource "aws_route53_record" "gateway_infra_home_a-rwx_org" {
  for_each = data.terraform_remote_state.unifi.outputs.site_addresses
  zone_id  = module.zones["a-rwx.org"].zone_id
  name     = "${each.value}.home.a-rwx.org"
  type     = "A"
  ttl      = "60"
  records  = [each.key]
}

resource "aws_route53_record" "linode" {
  for_each = data.terraform_remote_state.linode.outputs.instance_addresses

  zone_id = module.zones["a-rwx.org"].zone_id
  name    = "${each.key}.linode.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = [each.value]
}

resource "aws_route53_record" "alias_hub_a-rwx_org" {
  for_each = toset(var.hub_records)
  zone_id  = module.zones["a-rwx.org"].zone_id
  name     = "${each.key}.a-rwx.org"
  type     = "A"
  ttl      = "60"
  records  = ["10.0.1.112"]
}

resource "aws_route53_record" "dmz_int_a-rwx_org" {
  for_each = var.wg_records

  zone_id = module.zones["a-rwx.org"].zone_id
  name    = "${each.value}.wg0.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = [each.key]
}

resource "aws_route53_record" "alias_hass_a-rwx_org" {
  for_each = toset(var.hass_records)
  zone_id  = module.zones["a-rwx.org"].zone_id
  name     = each.key
  type     = "A"
  ttl      = "60"
  records  = ["10.0.1.80"]
}

resource "aws_route53_record" "linode_aliases" {
  for_each = var.linode_aliases

  zone_id = module.zones[replace(each.key, local.host_to_zone_regex, "$1")].zone_id
  name    = each.key
  type    = "A"
  ttl     = "60"
  records = [data.terraform_remote_state.linode.outputs.instance_addresses[each.value]]
}
