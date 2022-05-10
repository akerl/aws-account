locals {
  records = {
    # 10.0.0.0/24 Infra (VLAN nil)
    "10.0.0.1"  = "gateway.infra"
    "10.0.0.2"  = "core.infra"
    "10.0.0.3"  = "leaf.infra"
    "10.0.0.20" = "switch-theatre.infra"
    "10.0.0.21" = "switch-family.infra"
    "10.0.0.22" = "switch-office.infra"
    "10.0.0.23" = "switch4.infra"
    "10.0.0.24" = "switch5.infra"
    "10.0.0.40" = "wap-gym.infra"
    "10.0.0.41" = "wap-basement.infra"
    "10.0.0.42" = "wap-garage.infra"
    "10.0.0.43" = "wap-library.infra"
    "10.0.0.44" = "wap-master.infra"
    "10.0.0.45" = "wap-guest.infra"
    "10.0.0.50" = "eap-front.infra"
    "10.0.0.51" = "eap-fence.infra"
    "10.0.0.52" = "eap-deck.infra"
    # 10.0.1.0/24 Servers (VLAN 101)
    "10.0.1.90"  = "kiosk-tea.servers"
    "10.0.1.91"  = "kiosk-office.servers"
    "10.0.1.92"  = "kiosk-rack.servers"
    "10.0.1.110" = "influxdb.servers"
    "10.0.1.111" = "grafana.servers"
    "10.0.1.112" = "nginx.servers"
    "10.0.1.113" = "syslog.servers"
    "10.0.1.114" = "hass.servers"
    "10.0.1.115" = "monitor.servers"
    "10.0.1.116" = "bastion.servers"
    "10.0.1.150" = "nas.servers"
    # 10.0.2.0/24 security (VLAN 102)
    "10.0.2.2"  = "nas.security"
    "10.0.2.10" = "cam-front.security"
    "10.0.2.11" = "cam-deck.security"
    "10.0.2.12" = "cam-fence.security"
    "10.0.2.13" = "cam-garage.security"
    "10.0.2.24" = "cam-patio.security"
    # 172.16.0.0/22 IoT (VLAN 700)
    "172.16.1.10" = "cam-sunroom.iot"
    "172.16.1.11" = "cam-family.iot"
    "172.16.1.12" = "cam-living.iot"
    "172.16.1.13" = "cam-basement.iot"
    # 172.16.20.0/24 Gaming (VLAN 720)
    # 192.168.0.0/24 Standard (VLAN 900)
    # 192.168.99.0/24 Guest (VLAN 999)
  }

  nuc_vhosts = [
    "pumidor",
    "influxdb",
    "hass",
    "nvr",
  ]

  external_vhosts = [
    "pumidor",
  ]

  wg_vhosts = [
    "hass",
    "nvr",
  ]
}

module "a-rwx_org" {
  source            = "armorfret/r53-zone/aws"
  version           = "0.4.0"
  admin_email       = var.admin_email
  domain_name       = "a-rwx.org"
  delegation_set_id = aws_route53_delegation_set.main.id
}

resource "aws_route53_record" "a_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "a-rwx.org"
  type    = "A"

  alias {
    name                   = var.akerl-blog-redirect_dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_www_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "www.a-rwx.org"
  type    = "A"

  alias {
    name                   = var.akerl-blog-redirect_dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cname_home_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "home.a-rwx.org"
  type    = "CNAME"
  ttl     = "60"
  records = ["akerl.ddns.net"]
}

resource "aws_route53_record" "gateway_infra_home_a-rwx_org" {
  for_each = local.records
  zone_id  = module.a-rwx_org.zone_id
  name     = "${each.value}.home.a-rwx.org"
  type     = "A"
  ttl      = "60"
  records  = [each.key]
}

module "gateway_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.1.0"
  admin_email       = var.admin_email
  delegation_set_id = "gateway"
  subzone_name      = "gateway.infra.home.certs.a-rwx.org"
  cert_name         = "gateway.infra.home.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

resource "aws_route53_record" "proxy_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "proxy.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["45.79.135.98"]
}

resource "aws_route53_record" "dmz_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "dmz.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["45.33.65.28"]
}

resource "aws_route53_record" "gateway_external_a-rwx_org" {
  for_each = toset(local.external_vhosts)
  zone_id  = module.a-rwx_org.zone_id
  name     = "${each.value}.a-rwx.org"
  type     = "A"
  ttl      = "60"
  records  = ["45.79.135.98"]
}

resource "aws_route53_record" "gateway_wg_a-rwx_org" {
  for_each = toset(local.wg_vhosts)
  zone_id  = module.a-rwx_org.zone_id
  name     = "${each.value}.a-rwx.org"
  type     = "A"
  ttl      = "60"
  records  = ["10.255.255.1"]
}

resource "aws_route53_record" "gateway_nuc_infra_home_a-rwx_org" {
  for_each = toset(local.nuc_vhosts)
  zone_id  = module.a-rwx_org.zone_id
  name     = "${each.value}.nuc.servers.home.a-rwx.org"
  type     = "A"
  ttl      = "60"
  records  = ["10.0.1.100"]
}

module "nuc_vhost_validation" {
  for_each          = toset(local.nuc_vhosts)
  source            = "armorfret/r53-certbot/aws"
  version           = "0.1.0"
  admin_email       = var.admin_email
  delegation_set_id = "nuc_${each.value}"
  subzone_name      = "${each.value}.nuc.servers.home.certs.a-rwx.org"
  cert_name         = "${each.value}.nuc.servers.home.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

module "hass_ext_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.1.0"
  admin_email       = var.admin_email
  delegation_set_id = "hass_ext"
  subzone_name      = "hass.certs.a-rwx.org"
  cert_name         = "hass.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

module "nvr_ext_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.1.0"
  admin_email       = var.admin_email
  delegation_set_id = "nvr_ext"
  subzone_name      = "nvr.certs.a-rwx.org"
  cert_name         = "nvr.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

module "pumidor_ext_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.1.0"
  admin_email       = var.admin_email
  delegation_set_id = "pumidor_ext"
  subzone_name      = "pumidor.certs.a-rwx.org"
  cert_name         = "pumidor.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}
