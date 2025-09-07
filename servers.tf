locals {
  certificates = {
    "goat.akerl.app" : null,
    "charts.akerl.app" : null,
    "frameproxy.a-rwx.org" : null,
    "frame.akerl.app" : ["letsencrypt.org; validationmethods=dns-01", "amazon.com"],
    "syslog.servers.home.a-rwx.org" : null,
    "metrics.servers.home.a-rwx.org" : null,
    "influx.servers.home.a-rwx.org" : null,
    "heracles.servers.home.a-rwx.org" : null,
    "grafana.servers.home.a-rwx.org" : null,
    "printer.standard.home.a-rwx.org" : null,
    "nas.servers.home.a-rwx.org" : null,
    "hass.servers.home.a-rwx.org" : null,
    "baby.servers.home.a-rwx.org" : null,
    "logs.a-rwx.org" : null,
    "metrics.a-rwx.org" : null,
    "grafana.a-rwx.org" : null,
    "nvr.a-rwx.org" : null,
    "hass.a-rwx.org" : null,
    "baby.a-rwx.org" : null,
    "zwave.a-rwx.org" : null,
    "gateway.infra.home.a-rwx.org" : null,
  }
}

module "certificate_validation" {
  for_each    = local.certificates
  source      = "armorfret/r53-certbot/aws"
  version     = "0.6.5"
  admin_email = var.admin_email
  cert_name   = each.key
  zone_id     = module.zones[replace(each.key, local.host_to_zone_regex, "$1")].zone_id
  issue_list  = each.value
}

