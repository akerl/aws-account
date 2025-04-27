module "puppet-vault" {
  source         = "armorfret/s3-configvault/aws"
  version        = "0.3.3"
  prefix         = "puppet"
  vault_bucket   = "akerl-puppet"
  logging_bucket = aws_s3_bucket.logging.id
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
  ]
}
