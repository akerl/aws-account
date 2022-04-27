module "puppet-vault" {
  source         = "armorfret/s3-configvault/aws"
  version        = "0.0.6"
  prefix         = "puppet"
  vault_bucket   = "akerl-puppet"
  logging_bucket = module.account.logging_bucket
  servers = [
    "codepad",
    "dmz",
    "grafana",
    "hass",
    "host",
    "influxdb",
    "kiosk-office",
    "kiosk-rack",
    "kiosk-tea",
    "monitor",
    "nuc",
    "syslog",
    "teslacam",
  ]
}
