module "akerl-hook-site" {
  source         = "armorfret/lambda-hookexporter/aws"
  version        = "0.0.5"
  logging_bucket = aws_s3_bucket.logging.id
  config_bucket  = "akerl-hookexporter-config"
  data_bucket    = "akerl-hookexporter-data"
  lambda_bucket  = module.akerl-hookexporter.publish_bucket
  hostname       = "exporter.akerl.app"
}
