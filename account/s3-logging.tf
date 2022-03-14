resource "aws_s3_bucket" "logging" {
  bucket = "akerl-s3-logs"
}

resource "aws_s3_bucket_versioning" "logging" {
  bucket = aws_s3_bucket.logging.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "logging" {
  bucket = aws_s3_bucket.logging.id
  acl    = "log-delivery-write"
}

output "logging_bucket" {
  value = aws_s3_bucket.logging.id
}

