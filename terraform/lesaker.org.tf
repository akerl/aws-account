module "lesaker_org" {
    source = "./domain"
    domain_name = "lesaker.org"
    delegation_set_id = "${aws_route53_delegation_set.main.id}"
    root_ipv4 = "70.85.129.127"
    root_ipv6 = "2600:3c00:e001:9001::1"
}

resource "aws_route53_record" "cname_mail_lesaker_org" {
    zone_id = "${module.lesaker_org.zone_id}"
    name = "mail.lesaker.org"
    type = "CNAME"
    ttl = "86400"
    records = ["ghs.googlehosted.com."]
}

resource "aws_route53_record" "cname_cal_lesaker_org" {
    zone_id = "${module.lesaker_org.zone_id}"
    name = "cal.lesaker.org"
    type = "CNAME"
    ttl = "86400"
    records = ["ghs.googlehosted.com."]
}
