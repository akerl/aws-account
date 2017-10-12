resource "aws_s3_bucket" "publish-bucket" {
  bucket = "${var.publish-bucket}"

  versioning {
    enabled = "true"
  }

  logging {
    target_bucket = "${var.logging-bucket}"
    target_prefix = "${var.publish-bucket}/"
  }
  
  count = "${var.make-bucket}"
}
