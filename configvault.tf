module "puppet-vault" {
  source         = "armorfret/s3-configvault/aws"
  version        = "0.3.3"
  prefix         = "puppet"
  vault_bucket   = "akerl-puppet"
  logging_bucket = aws_s3_bucket.logging.id
  servers = [
    "codepad",
    "dmz",
    "grafana",
    "hass",
    "host",
    "hub",
    "kiosk-office",
    "kiosk-tea",
    "metrics",
    "syslog",
    "goat",
    "kiosk-poker",
    "charts",
    "unpoller",
    "proxy",
    "mqtt",
    "ledgerdb",
    "heracles",
  ]
}
