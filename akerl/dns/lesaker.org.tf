module "lesaker_org" {
  source            = "armorfret/r53-zone/aws"
  version           = "0.0.2"
  admin_email       = "${var.admin_email}"
  domain_name       = "lesaker.org"
  delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

resource "aws_route53_record" "a_lesaker_org" {
  zone_id = "${module.lesaker_org.zone_id}"
  name    = "lesaker.org"
  type    = "A"

  alias {
    name                   = "${var.akerl-blog-redirect-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_www_lesaker_org" {
  zone_id = "${module.lesaker_org.zone_id}"
  name    = "www.lesaker.org"
  type    = "A"

  alias {
    name                   = "${var.akerl-blog-redirect-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cname_mail_lesaker_org" {
  zone_id = "${module.lesaker_org.zone_id}"
  name    = "mail.lesaker.org"
  type    = "CNAME"
  ttl     = "86400"
  records = ["ghs.googlehosted.com."]
}

resource "aws_route53_record" "cname_cal_lesaker_org" {
  zone_id = "${module.lesaker_org.zone_id}"
  name    = "cal.lesaker.org"
  type    = "CNAME"
  ttl     = "86400"
  records = ["ghs.googlehosted.com."]
}
