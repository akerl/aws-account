resource "aws_iam_user" "circleci" {
  name = "circleci-akerl-madlibrarian"
}

data "aws_iam_policy_document" "quoteupdater" {
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

resource "aws_iam_user_policy" "quoteupdater" {
  name   = "quoteupdater"
  user   = "${aws_iam_user.circleci.name}"
  policy = "${data.aws_iam_policy_document.quoteupdater.json}"
}

resource "awscreds_iam_access_key" "circleci-key" {
  user = "${aws_iam_user.circleci.name}"
  file = "creds/${aws_iam_user.circleci.name}"
}
