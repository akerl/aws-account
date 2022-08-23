terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.4.0"
    }

    awscreds = {
      source  = "terraform.scrtybybscrty.org/armorfret/awscreds"
      version = "0.5.5"
    }
  }
}

resource "aws_iam_user" "build" {
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
      "ec2:Describe*",
      "events:Describe*",
      "events:List*",
      "iam:Get*",
      "iam:List*",
      "lambda:Get*",
      "lambda:List*",
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
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_user_policy" "terraform-planner" {
  name   = "terraform-planner"
  user   = aws_iam_user.build.name
  policy = data.aws_iam_policy_document.terraform-planner.json
}

resource "awscreds_iam_access_key" "build-key" {
  user = aws_iam_user.build.name
  file = "creds/${aws_iam_user.build.name}"
}

