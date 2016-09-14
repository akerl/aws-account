resource "aws_iam_user" "circleci" {
    name = "akerl-blog-circleci"
}

data "aws_iam_policy_document" "bucket-read-access" {
    statement {
        actions = ["s3:GetObject"]
        resources = ["arn:aws:s3:::*"]
        principals {
            type = "AWS"
            identifiers = ["*"]
        }
    }
}

data "aws_iam_policy_document" "blogupdater" {
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
        ],
        resources = [
            "arn:aws:s3:::${aws_s3_bucket.file-bucket.id}/*",
            "arn:aws:s3:::${aws_s3_bucket.file-bucket.id}",
        ]
    }
}

resource "aws_iam_user_policy" "blogupdater" {
    name = "blogupdater"
    user = "${aws_iam_user.circleci.name}"
    policy = "${data.aws_iam_policy_document.blogupdater.json}"
}

resource "awscreds_iam_access_key" "circleci-key" {
    user = "${aws_iam_user.circleci.name}"
    file = "creds/${aws_iam_user.circleci.name}"
}

