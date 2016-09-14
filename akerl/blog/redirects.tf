data "aws_iam_policy_document" "redirect-bucket-read-access" {
    statement {
        actions = ["s3:GetObject"]
        resources = ["arn:aws:s3:::${var.redirect-bucket}/*"]
        principals {
            type = "AWS"
            identifiers = ["*"]
        }
    }
}

resource "aws_s3_bucket" "redirect-bucket" {
    bucket = "${var.redirect-bucket}"
    policy = "${data.aws_iam_policy_document.redirect-bucket-read-access.json}"
    versioning {
        enabled = "true"
    }
    logging {
        target_bucket = "${var.logging-bucket}"
        target_prefix = "akerl-blog-redirect/s3/"
    }
    website {
        redirect_all_requests_to = "https://blog.akerl.org"
    }
}

resource "aws_cloudfront_distribution" "redirect_distribution" {
    origin {
        domain_name = "${aws_s3_bucket.redirect-bucket.website_endpoint}"
        origin_id = "redirect-bucket"
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
        prefix = "akerl-blog-redirect-cdn"
    }

    default_cache_behavior {
        allowed_methods = ["GET", "HEAD"]
        cached_methods = ["GET", "HEAD"]
        target_origin_id = "redirect-bucket"
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
