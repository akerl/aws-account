resource "aws_cloudtrail" "main-trail" {
    name = "main-trail"
    s3_bucket_name = "${aws_s3_bucket.main-trail.id}"
    include_global_service_events = true
    is_multi_region_trail = true
    enable_log_file_validation = true
    
}

resource "aws_s3_bucket" "main-trail" {
    bucket = "akerl-cloudtrail"
    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::akerl-cloudtrail"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::akerl-cloudtrail/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}
