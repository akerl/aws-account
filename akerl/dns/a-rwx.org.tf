locals {
  records = {
    # External
    "45.79.135.98" = "hass"
    "45.79.135.98" = "pumidor"
    # 10.0.0.0/24 Infra
    "10.0.0.1"   = "gateway.infra.home"
    "10.0.0.2"   = "core.infra.home"
    "10.0.0.10"  = "controller.infra.home"
    "10.0.0.20"  = "switch0.infra.home"
    "10.0.0.21"  = "switch1.infra.home"
    "10.0.0.22"  = "switch2.infra.home"
    "10.0.0.40"  = "wap0.infra.home"
    "10.0.0.41"  = "wap1.infra.home"
    "10.0.0.42"  = "wap2.infra.home"
    "10.0.0.100" = "nuc.infra.home"
    "10.0.0.101" = "hass-int.infra.home"
    # 10.1.0.0/16 Lab
    # 10.2.0.0/24 Trusted
    # 172.16.0.0/22 IoT
    "172.16.0.2"   = "thermostat.iot.home"
    "172.16.0.3"   = "garage.iot.home"
    "172.16.0.4"   = "printer.iot.home"
    "172.16.0.5"   = "washer.iot.home"
    "172.16.0.6"   = "dryer.iot.home"
    "172.16.0.7"   = "microwave.iot.home"
    "172.16.0.8"   = "oven.iot.home"
    "172.16.0.20"  = "doorbell.iot.home"
    "172.16.0.21"  = "cam-basement.iot.home"
    "172.16.0.22"  = "cam-dog.iot.home"
    "172.16.0.50"  = "smartthings.iot.home"
    "172.16.0.51"  = "harmony.iot.home"
    "172.16.0.52"  = "nestconnect.iot.home"
    "172.16.0.53"  = "august.iot.home"
    "172.16.0.60"  = "echo-kitchen.iot.home"
    "172.16.0.61"  = "echo-basement.iot.home"
    "172.16.0.62"  = "echo-family.iot.home"
    "172.16.0.70"  = "google-bedroom.iot.home"
    "172.16.0.80"  = "tv-basement.iot.home"
    "172.16.0.81"  = "tv-family.iot.home"
    "172.16.0.90"  = "chromecast-basement.iot.home"
    "172.16.0.91"  = "chromecast-family.iot.home"
    "172.16.0.100" = "hoid.iot.home"
    "172.16.1.1"   = "nanoleaf-office.iot.home"
    # 172.16.20.0/24 Gaming
    "172.16.20.20" = "ps4.gaming.home"
    "172.16.20.30" = "graff.gaming.home"
    # 192.168.0.0/24 Standard
    "192.168.0.20" = "szeth.standard.home"
    "192.168.0.21" = "lift.standard.home"
    "192.168.0.22" = "wrist.standard.home"
    "192.168.0.23" = "bean.standard.home"
    "192.168.0.30" = "mazer.standard.home"
    "192.168.0.31" = "mazer-wireless.standard.home"
    "192.168.0.40" = "kelly-iphone.standard.home"
    "192.168.0.41" = "kelly-ipad.standard.home"
    "192.168.0.50" = "switch.standard.home"
    # 192.168.99.0/24 Guest
  }

  nuc_vhosts = [
    "pumidor",
    "influxdb",
    "hass",
  ]
}

module "a-rwx_org" {
  source            = "armorfret/r53-zone/aws"
  version           = "0.3.2"
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
  records = ["akerl.dyndns.org"]
}

resource "aws_route53_record" "gateway_infra_home_a-rwx_org" {
  for_each = local.records
  zone_id  = module.a-rwx_org.zone_id
  name     = "${each.value}.a-rwx.org"
  type     = "A"
  ttl      = "60"
  records  = [each.key]
}

module "controller_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.0.3"
  admin_email       = var.admin_email
  delegation_set_id = "controller"
  subzone_name      = "controller.infra.home.certs.a-rwx.org"
  cert_name         = "controller.infra.home.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

resource "aws_route53_record" "gateway_nuc_infra_home_a-rwx_org" {
  for_each = toset(local.nuc_vhosts)
  zone_id  = module.a-rwx_org.zone_id
  name     = "${each.value}.nuc.infra.home.a-rwx.org"
  type     = "A"
  ttl      = "60"
  records  = ["10.0.0.100"]
}

module "nuc_vhost_validation" {
  for_each          = toset(local.nuc_vhosts)
  source            = "armorfret/r53-certbot/aws"
  version           = "0.0.3"
  admin_email       = var.admin_email
  delegation_set_id = "nuc_${each.value}"
  subzone_name      = "${each.value}.nuc.infra.home.certs.a-rwx.org"
  cert_name         = "${each.value}.nuc.infra.home.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

module "hass_ext_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.0.3"
  admin_email       = var.admin_email
  delegation_set_id = "hass_ext"
  subzone_name      = "hass.certs.a-rwx.org"
  cert_name         = "hass.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}

module "pumidor_ext_validation" {
  source            = "armorfret/r53-certbot/aws"
  version           = "0.0.3"
  admin_email       = var.admin_email
  delegation_set_id = "pumidor_ext"
  subzone_name      = "pumidor.certs.a-rwx.org"
  cert_name         = "pumidor.a-rwx.org"
  parent_zone_id    = module.a-rwx_org.zone_id
}
