resource "aws_iam_user" "circleci" {
  name = "circleci-akerl-aws-account"
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
      "cloudtrail:List*",
      "cloudtrail:Get*",
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
      "s3:ListBucket",
      "s3:GetLifecycleConfiguration",
      "s3:GetReplicationConfiguration",
      "s3:ListAllMyBuckets",
      "sns:Get*",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_user_policy" "terraform-planner" {
  name   = "terraform-planner"
  user   = "${aws_iam_user.circleci.name}"
  policy = "${data.aws_iam_policy_document.terraform-planner.json}"
}

resource "awscreds_iam_access_key" "circleci-key" {
  user = "${aws_iam_user.circleci.name}"
  file = "creds/${aws_iam_user.circleci.name}"
}
