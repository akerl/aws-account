resource "aws_s3_bucket" "data-bucket" {
  bucket = "${var.data-bucket}"

  versioning {
    enabled = "true"
  }

  logging {
    target_bucket = "${var.logging-bucket}"
    target_prefix = "akerl-blog/"
  }
}
