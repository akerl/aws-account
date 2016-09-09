module "akerl_org" {
    source = "./domain"
    domain_name = "akerl.org"
    delegation_set_id = "${aws_route53_delegation_set.main.id}"
    root_ipv4 = "70.85.129.127"
    root_ipv6 = "2600:3c00:e001:9001::1"
}

resource "aws_route53_record" "a_blog_akerl_org" {
    zone_id = "${module.akerl_org.zone_id}"
    name = "blog.akerl.org"
    type = "A"
    ttl = "86400"
    records = ["70.85.129.127"]
}

resource "aws_route53_record" "aaaa_blog_akerl_org" {
    zone_id = "${module.akerl_org.zone_id}"
    name = "blog.akerl.org"
    type = "AAAA"
    ttl = "86400"
    records = ["2600:3c00:e001:9001::1"]
}

resource "aws_route53_record" "a_committed_akerl_org" {
    zone_id = "${module.akerl_org.zone_id}"
    name = "committed.akerl.org"
    type = "A"
    ttl = "86400"
    records = ["70.85.129.127"]
}

resource "aws_route53_record" "aaaa_committed_akerl_org" {
    zone_id = "${module.akerl_org.zone_id}"
    name = "committed.akerl.org"
    type = "AAAA"
    ttl = "86400"
    records = ["2600:3c00:e001:9001::1"]
}
