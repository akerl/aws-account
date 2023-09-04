resource "aws_cloudtrail" "main-trail" { #trivy:ignore:AVD-AWS-0015 #trivy:ignore:AVD-AWS-0162
  name                          = "main-trail"
  s3_bucket_name                = aws_s3_bucket.main-trail.id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
}

resource "aws_s3_bucket" "main-trail" { #trivy:ignore:AVD-AWS-0089 #trivy:ignore:AVD-AWS-0321 #trivy:ignore:AVD-AWS-0163
  bucket = "akerl-cloudtrail"
}

resource "aws_s3_bucket_versioning" "main-trail" {
  bucket = aws_s3_bucket.main-trail.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "main-trail" {
  bucket                  = aws_s3_bucket.main-trail.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main-trail" { #trivy:ignore:AVD-AWS-0132
  bucket = aws_s3_bucket.main-trail.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "main-trail" {
  bucket = aws_s3_bucket.main-trail.id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::akerl-cloudtrail"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::akerl-cloudtrail/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY

}

resource "aws_s3_bucket" "logging" { #trivy:ignore:AVD-AWS-0321
  bucket = "akerl-s3-logs"
}

resource "aws_s3_bucket_public_access_block" "logging" {
  bucket                  = aws_s3_bucket.logging.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logging" {
  bucket = aws_s3_bucket.logging.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "logging" {
  bucket = aws_s3_bucket.logging.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "logging" {
  bucket = aws_s3_bucket.logging.id
  acl    = "log-delivery-write"
}

resource "aws_api_gateway_account" "account" {
  cloudwatch_role_arn = aws_iam_role.apigw_cloudwatch.arn
}

resource "aws_iam_role_policy" "apigw_cloudwatch" {
  name   = "apigw_cloudwatch"
  role   = aws_iam_role.apigw_cloudwatch.name
  policy = data.aws_iam_policy_document.apigw_cloudwatch_perms.json
}

resource "aws_iam_role" "apigw_cloudwatch" {
  name               = "apigw_cloudwatch"
  assume_role_policy = data.aws_iam_policy_document.apigw_cloudwatch_assume.json
}

data "aws_iam_policy_document" "apigw_cloudwatch_assume" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "apigateway.amazonaws.com",
      ]
    }
  }
}

data "aws_iam_policy_document" "apigw_cloudwatch_perms" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:FilterLogEvents",
      "logs:GetLogEvents",
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }
}
