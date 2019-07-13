resource "aws_s3_bucket" "logging" {
  bucket = "akerl-s3-logs"
  acl    = "log-delivery-write"

  versioning {
    enabled = true
  }
}

output "logging_bucket" {
  value = aws_s3_bucket.logging.id
}

