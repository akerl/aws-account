resource "aws_route53_record" "zwave_a-rwx_org" {
  zone_id = module.zones["a-rwx.org"].zone_id
  name    = "zwave.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["10.0.1.80"]
}

resource "aws_route53_record" "a_goat_akerl_app" {
  zone_id = module.zones["akerl.app"].zone_id
  name    = "goat.akerl.app"
  type    = "A"
  ttl     = "60"
  records = [data.terraform_remote_state.linode.outputs.instance_addresses["goat"]]
}

module "goat_ext_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.4"
  admin_email = var.admin_email
  cert_name   = "goat.akerl.app"
  zone_id     = module.zones["akerl.app"].zone_id
}

resource "aws_route53_record" "a_charts_akerl_app" {
  zone_id = module.zones["akerl.app"].zone_id
  name    = "charts.akerl.app"
  type    = "A"
  ttl     = "60"
  records = [data.terraform_remote_state.linode.outputs.instance_addresses["charts"]]
}

module "charts_ext_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.4"
  admin_email = var.admin_email
  cert_name   = "charts.akerl.app"
  zone_id     = module.zones["akerl.app"].zone_id
}

module "influxdb_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.4"
  admin_email = var.admin_email
  cert_name   = "influxdb.servers.home.a-rwx.org"
  zone_id     = module.zones["a-rwx.org"].zone_id
}

module "syslog_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.4"
  admin_email = var.admin_email
  cert_name   = "syslog.servers.home.a-rwx.org"
  zone_id     = module.zones["a-rwx.org"].zone_id
}

module "metrics_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.4"
  admin_email = var.admin_email
  cert_name   = "metrics.servers.home.a-rwx.org"
  zone_id     = module.zones["a-rwx.org"].zone_id
}

module "grafana_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.4"
  admin_email = var.admin_email
  cert_name   = "grafana.servers.home.a-rwx.org"
  zone_id     = module.zones["a-rwx.org"].zone_id
}

module "printer_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.4"
  admin_email = var.admin_email
  cert_name   = "printer.standard.home.a-rwx.org"
  zone_id     = module.zones["a-rwx.org"].zone_id
}

module "nas_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.4"
  admin_email = var.admin_email
  cert_name   = "nas.servers.home.a-rwx.org"
  zone_id     = module.zones["a-rwx.org"].zone_id
}

module "hass_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.4"
  admin_email = var.admin_email
  cert_name   = "hass.servers.home.a-rwx.org"
  zone_id     = module.zones["a-rwx.org"].zone_id
}

module "logs_ext_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.4"
  admin_email = var.admin_email
  cert_name   = "logs.a-rwx.org"
  zone_id     = module.zones["a-rwx.org"].zone_id
}

module "metrics_ext_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.4"
  admin_email = var.admin_email
  cert_name   = "metrics.a-rwx.org"
  zone_id     = module.zones["a-rwx.org"].zone_id
}

module "grafana_ext_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.4"
  admin_email = var.admin_email
  cert_name   = "grafana.a-rwx.org"
  zone_id     = module.zones["a-rwx.org"].zone_id
}

module "nvr_ext_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.4"
  admin_email = var.admin_email
  cert_name   = "nvr.a-rwx.org"
  zone_id     = module.zones["a-rwx.org"].zone_id
}

module "hass_ext_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.4"
  admin_email = var.admin_email
  cert_name   = "hass.a-rwx.org"
  zone_id     = module.zones["a-rwx.org"].zone_id
}

module "zwave_ext_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.4"
  admin_email = var.admin_email
  cert_name   = "zwave.a-rwx.org"
  zone_id     = module.zones["a-rwx.org"].zone_id
}

module "gateway_validation" {
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.4"
  admin_email = var.admin_email
  cert_name   = "gateway.infra.home.a-rwx.org"
  zone_id     = module.zones["a-rwx.org"].zone_id
}

