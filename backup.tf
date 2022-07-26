locals {
  user = "akerl-backups"
}

data "aws_iam_policy_document" "s3-write" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:PutObject",
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

resource "aws_s3_bucket_versioning" "backups" {
  bucket = aws_s3_bucket.backups.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "backups" {
  bucket = aws_s3_bucket.backups.id

  target_bucket = module.account.logging_bucket
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

resource "aws_iam_user" "backups" {
  name = local.user
}
