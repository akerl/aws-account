resource "aws_s3_bucket" "logging" {
    bucket = "${var.prefix}-s3-logs"
    acl = "log-delivery-write"
    versioning {
        enabled = true
    }
}

output "logging-bucket" {
    value = "${aws_s3_bucket.logging.id}"
}
