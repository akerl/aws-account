locals {
  records = {
    # 10.0.0.0/24 Infra (VLAN nil)
    "10.0.0.1"  = "gateway.infra"
    "10.0.0.2"  = "core.infra"
    "10.0.0.3"  = "leaf.infra"
    "10.0.0.20" = "switch-theatre.infra"
    "10.0.0.21" = "switch-family.infra"
    "10.0.0.22" = "switch-office.infra"
    "10.0.0.23" = "switch-spare-1.infra"
    "10.0.0.24" = "switch-spare-2.infra"
    "10.0.0.25" = "switch-spare-3.infra"
    "10.0.0.26" = "switch-spare-fe-1.infra"
    "10.0.0.27" = "switch-spare-fe-2.infra"
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
    "10.0.1.91"  = "kiosk-office.servers"
    "10.0.1.100" = "host.servers"
    "10.0.1.110" = "influxdb.servers"
    "10.0.1.112" = "hub.servers"
    "10.0.1.113" = "syslog.servers"
    "10.0.1.114" = "metrics.servers"
    "10.0.1.115" = "grafana.servers"
    "10.0.1.116" = "teslamate.servers"
    "10.0.1.117" = "cultivator.servers"
    "10.0.1.150" = "nas.servers"
    # 10.0.2.0/24 security (VLAN 102)
    "10.0.2.2"  = "nas.security"
    "10.0.2.10" = "cam-front.security"
    "10.0.2.11" = "cam-deck.security"
    "10.0.2.12" = "cam-fence.security"
    "10.0.2.13" = "cam-garage.security"
    "10.0.2.14" = "cam-patio.security"
    # 172.16.0.0/22 IoT (VLAN 700)
    "172.16.0.3"   = "vrroom.iot"
    "172.16.0.4"   = "tivo-family.iot"
    "172.16.0.5"   = "tivo-bar.iot"
    "172.16.0.6"   = "receiver-theatre.iot"
    "172.16.0.7"   = "tv-family.iot"
    "172.16.0.8"   = "tivo-bedroom.iot"
    "172.16.0.9"   = "tv-bedroom.iot"
    "172.16.0.10"  = "snoo.iot"
    "172.16.0.11"  = "simplisafe.iot"
    "172.16.0.12"  = "myq.iot"
    "172.16.0.13"  = "nanoleaf.iot"
    "172.16.0.14"  = "gaming-remote.iot"
    "172.16.0.15"  = "jasnah.iot"
    "172.16.0.16"  = "akerl-oasis.iot"
    "172.16.0.17"  = "tivo-theatre.iot"
    "172.16.0.20"  = "solar-gw-1.iot"
    "172.16.0.21"  = "solar-gw-2.iot"
    "172.16.0.22"  = "solar-pv-1.iot"
    "172.16.0.23"  = "solar-pv-2.iot"
    "172.16.0.24"  = "solar-pv-3.iot"
    "172.16.0.25"  = "ev-charger-1.iot"
    "172.16.0.26"  = "ev-charger-2.iot"
    "172.16.0.27"  = "ev-charger-3.iot"
    "172.16.0.30"  = "power-shou.iot"
    "172.16.0.31"  = "power-sheng.iot"
    "172.16.0.32"  = "power-serverfan.iot"
    "172.16.0.33"  = "power-chargers.iot"
    "172.16.0.34"  = "power-desktop.iot"
    "172.16.0.40"  = "rh-bedroom.iot"
    "172.16.0.41"  = "rh-nursery.iot"
    "172.16.0.42"  = "rh-office.iot"
    "172.16.0.43"  = "rh-tea.iot"
    "172.16.0.44"  = "rh-basement.iot"
    "172.16.1.10"  = "cam-sunroom.iot"
    "172.16.1.11"  = "cam-family.iot"
    "172.16.1.12"  = "cam-living.iot"
    "172.16.1.13"  = "cam-basement.iot"
    "172.16.1.18"  = "kiosk-poker.iot"
    "172.16.1.19"  = "kiosk-tea.iot"
    "172.16.1.20"  = "thermostat-bar.iot"
    "172.16.1.21"  = "thermostat-basement.iot"
    "172.16.1.22"  = "thermostat-library.iot"
    "172.16.1.23"  = "thermostat-kitchen.iot"
    "172.16.1.24"  = "thermostat-sunroom.iot"
    "172.16.1.25"  = "thermostat-master.iot"
    "172.16.1.26"  = "thermostat-guest.iot"
    "172.16.1.27"  = "nestconnect-1.iot"
    "172.16.1.29"  = "nesthello.iot"
    "172.16.1.30"  = "nestcam-nursery.iot"
    "172.16.1.40"  = "echo-basement.iot"
    "172.16.1.41"  = "echo-kitchen.iot"
    "172.16.1.42"  = "echo-bedroom.iot"
    "172.16.1.43"  = "echo-family.iot"
    "172.16.1.50"  = "airthings-hub.iot"
    "172.16.1.51"  = "airthings-office.iot"
    "172.16.1.60"  = "flic-office.iot"
    "172.16.1.61"  = "flic-bedroom.iot"
    "172.16.1.70"  = "owlet.iot"
    "172.16.1.71"  = "hatch.iot"
    "172.16.1.80"  = "roomba-rover.iot"
    "172.16.1.81"  = "roomba-spot.iot"
    "172.16.1.90"  = "chromecast-bedroom.iot"
    "172.16.1.101" = "lifx-1.iot"
    "172.16.1.102" = "lifx-2.iot"
    "172.16.1.103" = "lifx-3.iot"
    "172.16.1.110" = "smoke-basement.iot"
    "172.16.1.111" = "smoke-suite.iot"
    "172.16.1.112" = "smoke-gym.iot"
    "172.16.1.113" = "smoke-theatre.iot"
    "172.16.1.114" = "smoke-library.iot"
    "172.16.1.115" = "smoke-hallway.iot"
    "172.16.1.116" = "smoke-master.iot"
    "172.16.1.117" = "smoke-nursery.iot"
    "172.16.1.118" = "smoke-office.iot"
    "172.16.1.119" = "smoke-upstairs.iot"
    "172.16.1.120" = "smoke-guest.iot"
    # 172.16.20.0/24 Gaming (VLAN 720)
    "172.16.20.10" = "ps5.gaming"
    "172.16.20.11" = "hyrum.gaming"
    # 192.168.1.0/24 Standard (VLAN 900)
    "192.168.1.2"   = "printer.standard"
    "192.168.1.3"   = "usb-kvm.standard"
    "192.168.1.10"  = "lift.standard"
    "192.168.1.11"  = "szeth.standard"
    "192.168.1.12"  = "wilson.standard"
    "192.168.1.13"  = "wilson-wired.standard"
    "192.168.1.14"  = "laker-mac.standard"
    "192.168.1.15"  = "laker-mac-wired.standard"
    "192.168.1.16"  = "philote.standard"
    "192.168.1.18"  = "bean.standard"
    "192.168.1.19"  = "wrist.standard"
    "192.168.1.20"  = "switch.standard"
    "192.168.1.30"  = "appletv.standard"
    "192.168.1.100" = "kelly-switch-wired.standard"
    "192.168.1.101" = "kelly-imac.standard"
    "192.168.1.102" = "kelly-iphone.standard"
    "192.168.1.103" = "kelly-ipad.standard"
    "192.168.1.104" = "kelly-watch.standard"
    # 192.168.99.0/24 Guest (VLAN 999)
  }

  hub_records = [
    "nvr",
    "hass",
    "grafana",
  ]
}

module "a-rwx_org" {
  source            = "armorfret/r53-zone/aws"
  version           = "0.6.0"
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
  version           = "0.5.0"
  admin_email       = var.admin_email
  delegation_set_id = "gateway"
  subzone_name      = "gateway.infra.home.certs.a-rwx.org"
  cert_name         = "gateway.infra.home.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

resource "aws_route53_record" "dmz_hub_linode_a-rwx_org" {
  for_each = toset(local.hub_records)
  zone_id  = module.a-rwx_org.zone_id
  name     = "${each.key}.a-rwx.org"
  type     = "A"
  ttl      = "60"
  records  = ["10.0.1.112"]
}

resource "aws_route53_record" "logs_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "logs.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["10.0.1.112"]
}

resource "aws_route53_record" "metrics_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "metrics.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["10.0.1.112"]
}

resource "aws_route53_record" "dmz_linode_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "dmz.linode.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["96.126.107.11"]
}

resource "aws_route53_record" "codepad_linode_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "codepad.linode.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["172.104.214.163"]
}

resource "aws_route53_record" "goat_linode_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "goat.linode.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["170.187.160.67"]
}

resource "aws_route53_record" "dmz_int_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "dmz.wg0.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["10.255.255.1"]
}

resource "aws_route53_record" "zwave_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "zwave.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["10.0.1.80"]
}

resource "aws_route53_record" "codepad_int_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "codepad.wg0.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["10.255.255.5"]
}

resource "aws_route53_record" "goat_int_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "goat.wg0.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["10.255.255.6"]
}

module "influxdb_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.5.0"
  admin_email       = var.admin_email
  delegation_set_id = "influxdb"
  subzone_name      = "influxdb.servers.home.certs.a-rwx.org"
  cert_name         = "influxdb.servers.home.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

module "syslog_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.5.0"
  admin_email       = var.admin_email
  delegation_set_id = "syslog"
  subzone_name      = "syslog.servers.home.certs.a-rwx.org"
  cert_name         = "syslog.servers.home.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

module "metrics_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.5.0"
  admin_email       = var.admin_email
  delegation_set_id = "metrics"
  subzone_name      = "metrics.servers.home.certs.a-rwx.org"
  cert_name         = "metrics.servers.home.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

module "grafana_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.5.0"
  admin_email       = var.admin_email
  delegation_set_id = "grafana"
  subzone_name      = "grafana.servers.home.certs.a-rwx.org"
  cert_name         = "grafana.servers.home.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

module "printer_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.5.0"
  admin_email       = var.admin_email
  delegation_set_id = "printer"
  subzone_name      = "printer.standard.home.certs.a-rwx.org"
  cert_name         = "printer.standard.home.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

module "nas_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.5.0"
  admin_email       = var.admin_email
  delegation_set_id = "nas"
  subzone_name      = "nas.servers.home.certs.a-rwx.org"
  cert_name         = "nas.servers.home.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

module "hass_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.5.0"
  admin_email       = var.admin_email
  delegation_set_id = "hass"
  subzone_name      = "hass.servers.home.certs.a-rwx.org"
  cert_name         = "hass.servers.home.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

module "logs_ext_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.5.0"
  admin_email       = var.admin_email
  delegation_set_id = "logs"
  subzone_name      = "logs.certs.a-rwx.org"
  cert_name         = "logs.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

module "metrics_ext_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.5.0"
  admin_email       = var.admin_email
  delegation_set_id = "metrics"
  subzone_name      = "metrics.certs.a-rwx.org"
  cert_name         = "metrics.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

module "grafana_ext_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.5.0"
  admin_email       = var.admin_email
  delegation_set_id = "grafana"
  subzone_name      = "grafana.certs.a-rwx.org"
  cert_name         = "grafana.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

module "nvr_ext_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.5.0"
  admin_email       = var.admin_email
  delegation_set_id = "nvr"
  subzone_name      = "nvr.certs.a-rwx.org"
  cert_name         = "nvr.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

module "hass_ext_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.5.0"
  admin_email       = var.admin_email
  delegation_set_id = "hass"
  subzone_name      = "hass.certs.a-rwx.org"
  cert_name         = "hass.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

module "zwave_ext_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.5.0"
  admin_email       = var.admin_email
  delegation_set_id = "zwave"
  subzone_name      = "zwave.certs.a-rwx.org"
  cert_name         = "zwave.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}
