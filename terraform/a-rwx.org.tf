module "a_rwx_org" {
    source = "./domain"
    domain_name = "a_rwx.org"
    delegation_set_id = "${aws_route53_delegation_set.main.id}"
    root_ipv4 = "70.85.129.127"
    root_ipv6 = "2600:3c00:e001:9001::1"
}

resource "aws_route53_record" "a_miro_a_rwx_org" {
    zone_id = "${module.a_rwx_org.zone_id}"
    name = "miro.a_rwx.org"
    type = "A"
    ttl = "86400"
    records = ["97.107.129.127"]
}

resource "aws_route53_record" "aaaa_miro_a_rwx_org" {
    zone_id = "${module.a_rwx_org.zone_id}"
    name = "miro.a_rwx.org"
    type = "A"
    ttl = "86400"
    records = ["2600:3c03:e001:9001::1"]
}

resource "aws_route53_record" "a_olhado_a_rwx_org" {
    zone_id = "${module.a_rwx_org.zone_id}"
    name = "olhado.a_rwx.org"
    type = "A"
    ttl = "86400"
    records = ["70.85.129.127"]
}

resource "aws_route53_record" "aaaa_olhado_a_rwx_org" {
    zone_id = "${module.a_rwx_org.zone_id}"
    name = "olhado.a_rwx.org"
    type = "A"
    ttl = "86400"
    records = ["2600:3c00:e001:9001::1"]
}
