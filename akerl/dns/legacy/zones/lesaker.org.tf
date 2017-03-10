module "lesaker_org" {
  source            = "./domain"
  domain_name       = "lesaker.org"
  delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

resource "aws_route53_record" "a_lesaker_org" {
  zone_id = "${module.lesaker_org.zone_id}"
  name    = "lesaker.org"
  type    = "A"

  alias {
    name                   = "d3c22u04feroyw.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_www_lesaker_org" {
  zone_id = "${module.lesaker_org.zone_id}"
  name    = "www.lesaker.org"
  type    = "A"

  alias {
    name                   = "d3c22u04feroyw.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
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
