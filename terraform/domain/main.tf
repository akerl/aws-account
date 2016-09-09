variable "domain_name" {
    type = "string"
}

variable "admin_email" {
    type = "string"
    default = "admin.lesaker.org"
}

variable "delegation_set_id" {
    type = "string"
}

variable "root_ipv4" {
    type = "string"
    default = ""
}

variable "root_ipv6" {
    type = "string"
    default = ""
}

output "zone_id" {
    value = "${aws_route53_zone.domain.zone_id}"
}

resource "aws_route53_zone" "domain" {
    delegation_set_id = "${var.delegation_set_id}"
    name = "${var.domain_name}"
}

resource "aws_route53_record" "soa" {
    zone_id = "${aws_route53_zone.domain.zone_id}"
    name = "${var.domain_name}"
    type = "SOA"
    ttl = "86400"
    records = ["${aws_route53_zone.domain.name_servers.0}. ${var.admin_email}. 1 7200 900 1209600 3600"]
}

resource "aws_route53_record" "mx" {
    zone_id = "${aws_route53_zone.domain.zone_id}"
    name = "${var.domain_name}"
    type = "MX"
    ttl = "86400"
    records = [
        "1   aspmx.l.google.com.",
        "5   alt1.aspmx.l.google.com.",
        "5   alt2.aspmx.l.google.com.",
        "10  aspmx2.googlemail.com.",
        "10  aspmx3.googlemail.com."
    ]
}

resource "aws_route53_record" "spf" {
    zone_id = "${aws_route53_zone.domain.zone_id}"
    name = "${var.domain_name}"
    type = "SPF"
    ttl = "86400"
    records = ["v=spf1 a include:_spf.google.com ~all"]
}

resource "aws_route53_record" "txt" {
    zone_id = "${aws_route53_zone.domain.zone_id}"
    name = "${var.domain_name}"
    type = "TXT"
    ttl = "86400"
    records = ["v=spf1 a include:_spf.google.com ~all"]
}

resource "aws_route53_record" "a" {
    zone_id = "${aws_route53_zone.domain.zone_id}"
    name = "${var.domain_name}"
    type = "A"
    ttl = "86400"
    records = ["${var.root_ipv4}"]
    count="${replace(replace(var.root_ipv4,"/.+/","1"),"/^$/","0")}"
}

resource "aws_route53_record" "aaaa" {
    zone_id = "${aws_route53_zone.domain.zone_id}"
    name = "${var.domain_name}"
    type = "AAAA"
    ttl = "86400"
    records = ["${var.root_ipv6}"]
    count="${replace(replace(var.root_ipv6,"/.+/","1"),"/^$/","0")}"
}

resource "aws_route53_record" "www_a" {
    zone_id = "${aws_route53_zone.domain.zone_id}"
    name = "www.${var.domain_name}"
    type = "A"
    ttl = "86400"
    records = ["${var.root_ipv4}"]
    count="${replace(replace(var.root_ipv4,"/.+/","1"),"/^$/","0")}"
}

resource "aws_route53_record" "www_aaaa" {
    zone_id = "${aws_route53_zone.domain.zone_id}"
    name = "www.${var.domain_name}"
    type = "AAAA"
    ttl = "86400"
    records = ["${var.root_ipv6}"]
    count="${replace(replace(var.root_ipv6,"/.+/","1"),"/^$/","0")}"
}
