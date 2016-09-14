module "akerl_org" {
    source = "./domain"
    domain_name = "akerl.org"
    delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

resource "aws_route53_record" "a_akerl_org" {
    zone_id = "${module.akerl_org.zone_id}"
    name = "akerl.org"
    type = "A"
    alias {
        name = "d3c22u04feroyw.cloudfront.net"
        zone_id = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
    }
}

resource "aws_route53_record" "a_blog_akerl_org" {
    zone_id = "${module.akerl_org.zone_id}"
    name = "blog.akerl.org"
    type = "A"
    alias {
        name = "dvw7pswcn4cfg.cloudfront.net"
        zone_id = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
    }
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
