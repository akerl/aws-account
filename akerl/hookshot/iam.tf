resource "aws_iam_user" "circleci" {
  name = "circleci-akerl-hookshot"
}

data "aws_iam_policy_document" "lambda_publish" {
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
      "arn:aws:s3:::${aws_s3_bucket.data-bucket.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.data-bucket.id}",
    ]
  }
}

resource "aws_iam_user_policy" "lambda_publish" {
  name   = "lambda_publish"
  user   = "${aws_iam_user.circleci.name}"
  policy = "${data.aws_iam_policy_document.lambda_publish.json}"
}

resource "awscreds_iam_access_key" "circleci-key" {
  user = "${aws_iam_user.circleci.name}"
  file = "creds/${aws_iam_user.circleci.name}"
}
