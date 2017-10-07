data "aws_iam_policy_document" "redirect-bucket-read-access" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.redirect-bucket}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

data "aws_iam_policy_document" "site-bucket-read-access" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.file-bucket}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

data "aws_iam_policy_document" "write-access" {
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
      "arn:aws:s3:::${aws_s3_bucket.file-bucket.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.file-bucket.id}",
    ]
  }
}

resource "aws_iam_user" "write-user" {
  name = "${var.write-user}"
}

resource "aws_iam_user_policy" "write-policy" {
  name   = "write-access"
  user   = "${aws_iam_user.write-user.name}"
  policy = "${data.aws_iam_policy_document.write-access.json}"
}

resource "awscreds_iam_access_key" "access-key" {
  user = "${aws_iam_user.write-user.name}"
  file = "creds/${aws_iam_user.write-user.name}"
}
