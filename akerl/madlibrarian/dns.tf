resource "aws_route53_record" "dns" {
  zone_id = "${data.aws_route53_zone.zone.zone_id}"

  name = "${var.domain}"
  type = "A"

  alias {
    name                   = "${aws_api_gateway_domain_name.domain.cloudfront_domain_name}"
    zone_id                = "${aws_api_gateway_domain_name.domain.cloudfront_zone_id}"
    evaluate_target_health = true
  }
}

data "aws_route53_zone" "zone" {
  name         = "${var.domain}"
}
