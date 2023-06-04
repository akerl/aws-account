module "akerl-s3authproxy" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.7.0"
  logging_bucket = aws_s3_bucket.logging.id
  publish_bucket = "akerl-s3authproxy"
}

module "akerl-madlibrarian" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.7.0"
  publish_bucket = "akerl-madlibrarian"
  logging_bucket = aws_s3_bucket.logging.id
}

module "akerl-githubauthlambda" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.7.0"
  publish_bucket = "akerl-githubauthlambda"
  logging_bucket = aws_s3_bucket.logging.id
}

module "akerl-watchdog" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.7.0"
  publish_bucket = "akerl-watchdog"
  logging_bucket = aws_s3_bucket.logging.id
}

module "akerl-blindclock" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.7.0"
  publish_bucket = "akerl-blindclock"
  logging_bucket = aws_s3_bucket.logging.id
}

module "akerl-frame" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.7.0"
  publish_bucket = "akerl-frame"
  logging_bucket = aws_s3_bucket.logging.id
}

module "akerl-goat-backup" {
  source         = "armorfret/s3-publish/aws"
  version        = "0.7.0"
  publish_bucket = "akerl-goat-backup"
  logging_bucket = aws_s3_bucket.logging.id
}
