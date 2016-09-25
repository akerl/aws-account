resource "aws_iam_user" "circleci" {
  name = "akerl-aws-account-circleci"
}

data "aws_iam_policy_document" "terraform-planner" {
  statement {
    actions = [
      "iam:Get*",
      "iam:List*",
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
