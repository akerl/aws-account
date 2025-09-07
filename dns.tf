locals {
  hub_records = [
    "nvr",
    "hass",
    "grafana",
    "metrics",
    "logs",
    "baby",
  ]

  hass_records = [
    "zwave.a-rwx.org",
    "frameproxy.a-rwx.org",
  ]

  wg_records = {
    "10.255.255.1" : "dmz",
    "10.255.255.2" : "hub",
    "10.255.255.3" : "k8s",
    "10.255.255.4" : "metrics",
    "10.255.255.5" : "codepad",
    "10.255.255.6" : "goat",
    "10.255.255.7" : "charts",
    "10.255.255.8" : "heracles",
    "10.255.255.9" : "proxy",
  }

  linode_aliases = {
    "goat.akerl.app" : "goat",
    "charts.akerl.app" : "charts",
  }
}

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
  for_each = toset(local.hub_records)
  zone_id  = module.zones["a-rwx.org"].zone_id
  name     = "${each.key}.a-rwx.org"
  type     = "A"
  ttl      = "60"
  records  = ["10.0.1.112"]
}

resource "aws_route53_record" "dmz_int_a-rwx_org" {
  for_each = local.wg_records

  zone_id = module.zones["a-rwx.org"].zone_id
  name    = "${each.value}.wg0.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = [each.key]
}

resource "aws_route53_record" "alias_hass_a-rwx_org" {
  for_each = toset(local.hass_records)
  zone_id  = module.zones["a-rwx.org"].zone_id
  name     = each.key
  type     = "A"
  ttl      = "60"
  records  = ["10.0.1.80"]
}

resource "aws_route53_record" "linode_aliases" {
  for_each = local.linode_aliases

  zone_id = module.zones[replace(each.key, local.host_to_zone_regex, "$1")].zone_id
  name    = each.key
  type    = "A"
  ttl     = "60"
  records = [data.terraform_remote_state.linode.outputs.instance_addresses[each.value]]
}
