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

module "publish-user" {
  source         = "../../modules/publish"
  logging-bucket = "${var.logging-bucket}"
  publish-bucket = "${var.file-bucket}"
  make-bucket    = "0"
}
