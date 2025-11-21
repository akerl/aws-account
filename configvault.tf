module "puppet-vault" {
  source         = "armorfret/s3-configvault/aws"
  version        = "0.4.0"
  prefix         = "puppet"
  vault_bucket   = "akerl-puppet"
  logging_bucket = aws_s3_bucket.logging.id
  servers        = var.servers
}
