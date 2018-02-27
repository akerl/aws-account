module "lesaker_com" {
  source            = "../../modules/domain"
  domain_name       = "lesaker.com"
  delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

resource "aws_route53_record" "a_lesaker_com" {
  zone_id = "${module.lesaker_com.zone_id}"
  name    = "lesaker.com"
  type    = "A"

  alias {
    name                   = "${var.akerl-blog-redirect-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_www_lesaker_com" {
  zone_id = "${module.lesaker_com.zone_id}"
  name    = "www.lesaker.com"
  type    = "A"

  alias {
    name                   = "${var.akerl-blog-redirect-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}
