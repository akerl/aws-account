locals {
  hub_records = [
    "nvr",
    "hass",
    "grafana",
  ]
}

data "terraform_remote_state" "linode" {
  backend = "http"
  config = {
    address = "https://raw.githubusercontent.com/akerl/linode-account/main/terraform.tfstate"
  }
}

data "terraform_remote_state" "unifi" {
  backend = "http"
  config = {
    address = "https://raw.githubusercontent.com/akerl/unifi-site/main/terraform.tfstate"
  }
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
    name                   = module.akerl-blog.redirect_dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_www_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "www.a-rwx.org"
  type    = "A"

  alias {
    name                   = module.akerl-blog.redirect_dns_name
    zone_id                = module.akerl-blog.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "gateway_infra_home_a-rwx_org" {
  for_each = data.terraform_remote_state.unifi.outputs.site_addresses
  zone_id  = module.a-rwx_org.zone_id
  name     = "${each.value}.home.a-rwx.org"
  type     = "A"
  ttl      = "60"
  records  = [each.key]
}

module "gateway_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.2"
  admin_email = var.admin_email
  cert_name   = "gateway.infra.home.a-rwx.org"
  zone_id     = module.a-rwx_org.zone_id
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

resource "aws_route53_record" "linode" {
  for_each = data.terraform_remote_state.linode.outputs.instance_addresses

  zone_id = module.a-rwx_org.zone_id
  name    = "${each.key}.linode.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = [each.value]
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

resource "aws_route53_record" "charts_int_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "charts.wg0.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["10.255.255.7"]
}

module "influxdb_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.2"
  admin_email = var.admin_email
  cert_name   = "influxdb.servers.home.a-rwx.org"
  zone_id     = module.a-rwx_org.zone_id
}

module "syslog_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.2"
  admin_email = var.admin_email
  cert_name   = "syslog.servers.home.a-rwx.org"
  zone_id     = module.a-rwx_org.zone_id
}

module "metrics_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.2"
  admin_email = var.admin_email
  cert_name   = "metrics.servers.home.a-rwx.org"
  zone_id     = module.a-rwx_org.zone_id
}

module "grafana_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.2"
  admin_email = var.admin_email
  cert_name   = "grafana.servers.home.a-rwx.org"
  zone_id     = module.a-rwx_org.zone_id
}

module "printer_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.2"
  admin_email = var.admin_email
  cert_name   = "printer.standard.home.a-rwx.org"
  zone_id     = module.a-rwx_org.zone_id
}

module "nas_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.2"
  admin_email = var.admin_email
  cert_name   = "nas.servers.home.a-rwx.org"
  zone_id     = module.a-rwx_org.zone_id
}

module "hass_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.2"
  admin_email = var.admin_email
  cert_name   = "hass.servers.home.a-rwx.org"
  zone_id     = module.a-rwx_org.zone_id
}

module "logs_ext_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.2"
  admin_email = var.admin_email
  cert_name   = "logs.a-rwx.org"
  zone_id     = module.a-rwx_org.zone_id
}

module "metrics_ext_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.2"
  admin_email = var.admin_email
  cert_name   = "metrics.a-rwx.org"
  zone_id     = module.a-rwx_org.zone_id
}

module "grafana_ext_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.2"
  admin_email = var.admin_email
  cert_name   = "grafana.a-rwx.org"
  zone_id     = module.a-rwx_org.zone_id
}

module "nvr_ext_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.2"
  admin_email = var.admin_email
  cert_name   = "nvr.a-rwx.org"
  zone_id     = module.a-rwx_org.zone_id
}

module "hass_ext_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.2"
  admin_email = var.admin_email
  cert_name   = "hass.a-rwx.org"
  zone_id     = module.a-rwx_org.zone_id
}

module "zwave_ext_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.2"
  admin_email = var.admin_email
  cert_name   = "zwave.a-rwx.org"
  zone_id     = module.a-rwx_org.zone_id
}
