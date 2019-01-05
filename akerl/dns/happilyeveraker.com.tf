module "happilyeveraker_com" {
  source            = "github.com/akerl/terraform-aws-r53-zone"
  admin_email       = "${var.admin_email}"
  domain_name       = "happilyeveraker.com"
  delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

resource "aws_route53_record" "a_happilyeveraker_com" {
  zone_id = "${module.happilyeveraker_com.zone_id}"
  name    = "happilyeveraker.com"
  type    = "A"

  alias {
    name                   = "${var.akerl-wedding-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_www_happilyeveraker_com" {
  zone_id = "${module.happilyeveraker_com.zone_id}"
  name    = "www.happilyeveraker.com"
  type    = "A"

  alias {
    name                   = "${var.akerl-wedding-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}
