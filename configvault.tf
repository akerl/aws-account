module "puppet-vault" {
  source         = "armorfret/s3-configvault/aws"
  version        = "0.2.0"
  prefix         = "puppet"
  vault_bucket   = "akerl-puppet"
  logging_bucket = module.account.logging_bucket
  servers = [
    "codepad",
    "dmz",
    "grafana",
    "hass",
    "host",
    "hub",
    "influxdb",
    "kiosk-office",
    "kiosk-tea",
    "metrics",
    "pumidor",
    "syslog",
    "teslamate",
    "goat",
  ]
}
