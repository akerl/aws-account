resource "aws_iam_user" "circleci" {
  name = "circleci-${var.publish-bucket}"
}

data "aws_iam_policy_document" "publish" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:ListBucket",
      "s3:ListAllMyBuckets",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::${var.publish-bucket}/*",
      "arn:aws:s3:::${var.publish-bucket}",
    ]
  }
}

resource "aws_iam_user_policy" "s3_publish" {
  name   = "s3_publish"
  user   = "${aws_iam_user.circleci.name}"
  policy = "${data.aws_iam_policy_document.publish.json}"
}

resource "awscreds_iam_access_key" "circleci-key" {
  user = "${aws_iam_user.circleci.name}"
  file = "creds/${aws_iam_user.circleci.name}"
}
