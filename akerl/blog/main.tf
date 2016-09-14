variable "logging-bucket" {
    type = "string"
}

resource "aws_iam_user" "circleci" {
    name = "akerl-blog-circleci"
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

resource "aws_s3_bucket" "file-bucket" {
    bucket = "akerl-blog"
    versioning {
        enabled = "true"
    }
    logging {
        target_bucket = "${var.logging-bucket}"
        target_prefix = "akerl-blog/s3/"
    }
    website {
        index_document = "index.html"
        error_document = "404/index.html"
    }
}

resource "aws_cloudfront_distribution" "blog_distribution" {
    origin {
        domain_name = "${aws_s3_bucket.file-bucket.website_endpoint}"
        origin_id = "blog-bucket"
        custom_origin_config {
            http_port = "80"
            https_port = "443"
            origin_protocol_policy = "http-only"
            origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
        }
    }

    aliases = [
        "lesaker.org",
        "www.lesaker.org",
        "blog.akerl.org",
        "scrtybybscrty.org",
        "lesaker.com",
        "akerl.org",
        "akerl.com",
        "www.akerl.org",
        "www.lesaker.com",
        "www.akerl.com",
    ]

    enabled = true
    default_root_object = "index.html"

    logging_config {
        include_cookies = false
        bucket = "${var.logging-bucket}.s3.amazonaws.com"
        prefix = "akerl-blog/cloudfront/"
    }

    default_cache_behavior {
        allowed_methods = ["GET", "HEAD"]
        cached_methods = ["GET", "HEAD"]
        target_origin_id = "blog-bucket"
        forwarded_values {
            query_string = false
            cookies {
                forward = "none"
            }
        }
        viewer_protocol_policy = "redirect-to-https"
        min_ttl = 0
        default_ttl = 300
        max_ttl = 300
        compress = true
    }

    price_class = "PriceClass_100"

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    viewer_certificate {
        ssl_support_method = "sni-only"
        minimum_protocol_version = "TLSv1"
        acm_certificate_arn = "arn:aws:acm:us-east-1:764218738161:certificate/4c6b3548-844f-4619-9a0d-7731906e6cd2"
    }
}
