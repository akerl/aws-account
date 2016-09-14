module "scrtybybscrty_org" {
    source = "./domain"
    domain_name = "scrtybybscrty.org"
    delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

resource "aws_route53_record" "a_scrtybybscrty_org" {
    zone_id = "${module.scrtybybscrty_org.zone_id}"
    name = "scrtybybscrty.org"
    type = "A"
    alias {
        name = "d3c22u04feroyw.cloudfront.net"
        zone_id = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
    }
}

resource "aws_route53_record" "a_www_scrtybybscrty_org" {
    zone_id = "${module.scrtybybscrty_org.zone_id}"
    name = "www.scrtybybscrty.org"
    type = "A"
    alias {
        name = "d3c22u04feroyw.cloudfront.net"
        zone_id = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
    }
}

resource "aws_route53_record" "cname_repo_scrtybybscrty_org" {
    zone_id = "${module.scrtybybscrty_org.zone_id}"
    name = "repo.scrtybybscrty.org"
    type = "CNAME"
    ttl = "86400"
    records = ["d2zau5gkfcknai.cloudfront.net."]
}
