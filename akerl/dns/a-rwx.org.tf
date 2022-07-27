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
    "10.0.1.80"  = "hass.servers"
    "10.0.1.90"  = "kiosk-tea.servers"
    "10.0.1.91"  = "kiosk-office.servers"
    "10.0.1.92"  = "kiosk-rack.servers"
    "10.0.1.100" = "host.servers"
    "10.0.1.110" = "influxdb.servers"
    "10.0.1.111" = "pumidor.servers"
    "10.0.1.112" = "hub.servers"
    "10.0.1.150" = "nas.servers"
    # 10.0.2.0/24 security (VLAN 102)
    "10.0.2.2"  = "nas.security"
    "10.0.2.10" = "cam-front.security"
    "10.0.2.11" = "cam-deck.security"
    "10.0.2.12" = "cam-fence.security"
    "10.0.2.13" = "cam-garage.security"
    "10.0.2.24" = "cam-patio.security"
    # 172.16.0.0/22 IoT (VLAN 700)
    "172.16.0.10" = "basement-receiver.iot"
    "172.16.1.10" = "cam-sunroom.iot"
    "172.16.1.11" = "cam-family.iot"
    "172.16.1.12" = "cam-living.iot"
    "172.16.1.13" = "cam-basement.iot"
    # 172.16.20.0/24 Gaming (VLAN 720)
    # 192.168.1.0/24 Standard (VLAN 900)
    "192.168.1.14" = "philote.standard"
    # 192.168.99.0/24 Guest (VLAN 999)
  }
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
  version           = "0.1.1"
  admin_email       = var.admin_email
  delegation_set_id = "gateway"
  subzone_name      = "gateway.infra.home.certs.a-rwx.org"
  cert_name         = "gateway.infra.home.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

resource "aws_route53_record" "dmz_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "dmz.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["96.126.107.11"]
}

module "influxdb_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.1.1"
  admin_email       = var.admin_email
  delegation_set_id = "influxdb"
  subzone_name      = "influxdb.servers.home.certs.a-rwx.org"
  cert_name         = "influxdb.servers.home.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

module "pumidor_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.1.1"
  admin_email       = var.admin_email
  delegation_set_id = "pumidor"
  subzone_name      = "pumidor.servers.home.certs.a-rwx.org"
  cert_name         = "pumidor.servers.home.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

module "nas_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.1.1"
  admin_email       = var.admin_email
  delegation_set_id = "nas"
  subzone_name      = "nas.servers.home.certs.a-rwx.org"
  cert_name         = "nas.servers.home.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}
