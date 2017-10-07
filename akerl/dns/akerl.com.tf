module "akerl_com" {
  source            = "./domain"
  domain_name       = "akerl.com"
  delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

resource "aws_route53_record" "a_akerl_com" {
  zone_id = "${module.akerl_com.zone_id}"
  name    = "akerl.com"
  type    = "A"

  alias {
    name                   = "${var.blog-redirect-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_www_akerl_com" {
  zone_id = "${module.akerl_com.zone_id}"
  name    = "www.akerl.com"
  type    = "A"

  alias {
    name                   = "${var.blog-redirect-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}
