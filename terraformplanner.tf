resource "aws_iam_user" "terraform-planner" { #trivy:ignore:AVD-AWS-0143
  name = "build-akerl-aws-account"
}

data "aws_iam_policy_document" "terraform-planner" {
  statement {
    actions = [
      "acm:Describe*",
      "acm:List*",
      "apigateway:Get*",
      "budgets:View*",
      "cloudfront:Get*",
      "cloudfront:List*",
      "cloudtrail:Describe*",
      "cloudtrail:Get*",
      "cloudtrail:List*",
      "cloudwatch:Describe*",
      "cloudwatch:List*",
      "cur:Describe*",
      "ec2:Describe*",
      "events:Describe*",
      "events:List*",
      "iam:Get*",
      "iam:List*",
      "lambda:Get*",
      "lambda:List*",
      "logs:Describe*",
      "logs:List*",
      "route53:Get*",
      "route53:List*",
      "s3:GetAccelerateConfiguration",
      "s3:GetBucket*",
      "s3:GetEncryptionConfiguration",
      "s3:GetLifecycleConfiguration",
      "s3:GetReplicationConfiguration",
      "s3:ListAllMyBuckets",
      "s3:ListBucket",
      "ses:Get*",
      "sns:Get*",
      "sns:List*",
      "sqs:Get*",
      "sqs:List*",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_user_policy" "terraform-planner" {
  name   = "terraform-planner"
  user   = aws_iam_user.terraform-planner.name
  policy = data.aws_iam_policy_document.terraform-planner.json
}

resource "awscreds_iam_access_key" "build-key" {
  user = aws_iam_user.terraform-planner.name
  file = "creds/${aws_iam_user.terraform-planner.name}"
}

