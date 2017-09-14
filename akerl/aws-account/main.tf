resource "aws_iam_user" "circleci" {
  name = "akerl-aws-account-circleci"
}

data "aws_iam_policy_document" "terraform-planner" {
  statement {
    actions = [
      "acm:List*",
      "apigateway:Get*",
      "cloudfront:Get*",
      "cloudfront:List*",
      "cloudtrail:Describe*",
      "cloudtrail:List*",
      "cloudtrail:Get*",
      "cloudwatch:Describe*",
      "iam:Get*",
      "iam:List*",
      "lambda:Get*",
      "route53:Get*",
      "route53:List*",
      "s3:GetAccelerateConfiguration",
      "s3:GetBucket*",
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
  file = "creds/akerl-aws-account-circleci"
}
