resource "aws_cloudtrail" "main-trail" {
  name                          = "main-trail"
  s3_bucket_name                = aws_s3_bucket.main-trail.id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::"]
    }
  }

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type   = "AWS::Lambda::Function"
      values = ["arn:aws:lambda"]
    }
  }
}

resource "aws_s3_bucket" "main-trail" {
  bucket = "akerl-cloudtrail"
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

resource "aws_s3_bucket" "logging" {
  bucket = "akerl-s3-logs"
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
