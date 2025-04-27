locals {
  hub_records = [
    "nvr",
    "hass",
    "grafana",
    "metrics",
    "logs",
    "baby",
  ]

  wg_records = {
    "10.255.255.1" : "dmz",
    "10.255.255.2" : "hub",
    "10.255.255.3" : "k8s",
    "10.255.255.4" : "metrics",
    "10.255.255.5" : "codepad",
    "10.255.255.6" : "goat",
    "10.255.255.7" : "charts",
    "10.255.255.8" : "influxdb",
    "10.255.255.9" : "proxy",
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

resource "aws_route53_record" "dmz_hub_linode_a-rwx_org" {
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
