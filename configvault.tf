module "puppet-vault" {
  source         = "armorfret/s3-configvault/aws"
  version        = "0.3.2"
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
    "influxdb",
    "kiosk-office",
    "kiosk-tea",
    "metrics",
    "syslog",
    "teslamate",
    "goat",
    "usb-kvm",
    "kiosk-poker",
    "cultivator",
    "charts",
    "unpoller",
  ]
}
