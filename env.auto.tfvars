admins = [
  "akerl-codepad",
  "akerl-wilson",
  "akerl-hafte",
]

billing_email = "me@lesaker.org"
admin_email   = "admin@lesaker.org"

domains = [
  "a-rwx.org", # legacy
  "aker.family",
  "akerl.app", # legacy
  "akerl.com",
  "akerl.org",
  "aliceaker.com",
  "carolineaker.com",
  "claireaker.com",
  "happilyeveraker.com",
  "kellywatts.com",
  "lesaker.com",
  "lesaker.org",
  "sophieaker.com",
]

servers = [
  "charts",
  "codepad",
  "dmz",
  "goat",
  "grafana",
  "hass",
  "heracles",
  "host",
  "hub",
  "k8s",
  "kiosk-office",
  "kiosk-poker",
  "kiosk-tea",
  "metrics",
  "mqtt",
  "proxy",
  "syslog",
  "unpoller",
  "baby",
  "influx",
  "garmin",
]

backup_user = "akerl-backups"

hub_records = [
  "nvr",
  "hass",
  "grafana",
  "metrics",
  "logs",
  "baby",
  "vrroom",
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
  "vrroom.a-rwx.org" : null,
}
