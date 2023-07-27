locals {
  wedding_domains = [
    "happilyeveraker.com",
    "www.happilyeveraker.com",
  ]
}

data "aws_iam_policy_document" "wedding_redirect_bucket-read-access" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.wedding_redirect_bucket.id}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket" "wedding_redirect_bucket" {
  bucket = "akerl-wedding-redirect"
}

resource "aws_s3_bucket_logging" "wedding_redirect_bucket" {
  bucket        = aws_s3_bucket.wedding_redirect_bucket.id
  target_bucket = aws_s3_bucket.logging.id
  target_prefix = "akerl-wedding-redirect/"
}

resource "aws_s3_bucket_policy" "wedding_redirect_bucket" {
  bucket = aws_s3_bucket.wedding_redirect_bucket.id
  policy = data.aws_iam_policy_document.wedding_redirect_bucket-read-access.json
}

resource "aws_s3_bucket_versioning" "wedding_redirect_bucket" {
  bucket = aws_s3_bucket.wedding_redirect_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_website_configuration" "wedding_redirect_bucket" {
  bucket = aws_s3_bucket.wedding_redirect_bucket.bucket
  redirect_all_requests_to {
    host_name = "www.theknot.com/us/kelly-watts-and-les-aker-may-2017"
    protocol  = "https"
  }
}

resource "aws_cloudfront_distribution" "wedding_redirect_distribution" {
  origin {
    domain_name = aws_s3_bucket_website_configuration.wedding_redirect_bucket.website_endpoint
    origin_id   = "redirect_bucket"

    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  aliases = local.wedding_domains

  enabled = true

  logging_config {
    include_cookies = false
    bucket          = "${aws_s3_bucket.logging.id}.s3.amazonaws.com"
    prefix          = "akerl-wedding-redirect-cdn"
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "redirect_bucket"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 300
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
    minimum_protocol_version = "TLSv1.2_2018"
    acm_certificate_arn      = module.wedding_certificate.arn
  }
}

module "wedding_certificate" {
  source    = "armorfret/acm-certificate/aws"
  version   = "0.3.0"
  hostnames = local.wedding_domains
}

resource "aws_route53_record" "a_happilyeveraker_com" {
  zone_id = module.zones["happilyeveraker.com"].zone_id
  name    = "happilyeveraker.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.wedding_redirect_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.wedding_redirect_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_www_happilyeveraker_com" {
  zone_id = module.zones["happilyeveraker.com"].zone_id
  name    = "www.happilyeveraker.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.wedding_redirect_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.wedding_redirect_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
