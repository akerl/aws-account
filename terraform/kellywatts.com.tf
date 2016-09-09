module "kellywatts_com" {
    source = "./domain"
    domain_name = "kellywatts.com"
    delegation_set_id = "${aws_route53_delegation_set.main.id}"
    root_ipv4 = "66.6.44.4"
}

resource "aws_route53_record" "cname_www_kellywatts_com" {
    zone_id = "${module.kellywatts_com.zone_id}"
    name = "www.kellywatts.com"
    type = "CNAME"
    ttl = "86400"
    records = ["domains.tumblr.com."]
}
