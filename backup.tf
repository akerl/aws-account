locals {
  user = "akerl-backups"
}

data "aws_iam_policy_document" "s3-write" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:PutObject",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::${local.user}",
      "arn:aws:s3:::${local.user}/*",
    ]
  }
}

resource "aws_s3_bucket" "backups" {
  bucket = local.user
}

resource "aws_s3_bucket_lifecycle_configuration" "backups" {
  bucket = aws_s3_bucket.backups.id

  rule {
    id     = "expiry"
    status = "Enabled"

    filter {}

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}

resource "aws_s3_bucket_public_access_block" "backups" {
  bucket                  = aws_s3_bucket.backups.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "backups" { #trivy:ignore:AVD-AWS-0132
  bucket = aws_s3_bucket.backups.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "backups" {
  bucket = aws_s3_bucket.backups.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "backups" {
  bucket = aws_s3_bucket.backups.id

  target_bucket = aws_s3_bucket.logging.id
  target_prefix = "${aws_s3_bucket.backups.id}/"
}

resource "aws_iam_user_policy" "backups" {
  user   = local.user
  name   = "s3-write"
  policy = data.aws_iam_policy_document.s3-write.json
}

resource "awscreds_iam_access_key" "backups" {
  user = local.user
  file = "creds/${local.user}"
}

resource "aws_iam_user" "backups" { #trivy:ignore:AVD-AWS-0143
  name = local.user
}
