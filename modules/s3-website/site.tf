resource "aws_s3_bucket" "file-bucket" {
  bucket = "${var.file-bucket}"
  policy = "${data.aws_iam_policy_document.site-bucket-read-access.json}"

  versioning {
    enabled = "true"
  }

  logging {
    target_bucket = "${var.logging-bucket}"
    target_prefix = "${var.file-bucket}/"
  }

  website {
    index_document = "index.html"
    error_document = "${var.error-document}"
  }
}

resource "aws_cloudfront_distribution" "site_distribution" {
  origin {
    domain_name = "${aws_s3_bucket.file-bucket.website_endpoint}"
    origin_id   = "site-bucket"

    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  aliases = ["${var.root-domain}"]

  enabled             = true
  default_root_object = "index.html"

  logging_config {
    include_cookies = false
    bucket          = "${var.logging-bucket}.s3.amazonaws.com"
    prefix          = "${var.file-bucket}-cdn/"
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "site-bucket"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 300
    compress               = true
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "${var.tls-level}"
    acm_certificate_arn      = "${module.certificate.arn}"
  }
}

module "certificate" {
  source = "../../modules/certificate"
  domains = "${concat(list(var.root-domain), var.redirect-domains)}"
}
