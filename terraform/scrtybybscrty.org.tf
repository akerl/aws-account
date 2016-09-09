module "scrtybybscrty_org" {
    source = "./domain"
    domain_name = "scrtybybscrty.org"
    delegation_set_id = "${aws_route53_delegation_set.main.id}"
    root_ipv4 = "70.85.129.127"
    root_ipv6 = "2600:3c00:e001:9001::1"
}

resource "aws_route53_record" "cname_repo_scrtybybscrty_org" {
    zone_id = "${module.scrtybybscrty_org.zone_id}"
    name = "scrtybybscrty.org"
    type = "CNAME"
    ttl = "86400"
    records = ["d2zau5gkfcknai.cloudfront.net."]
}
