module "akerl_com" {
    source = "./domain"
    domain_name = "akerl.com"
    delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

resource "aws_route53_record" "a_akerl_com" {
    zone_id = "${module.akerl_com.zone_id}"
    name = "akerl.com"
    type = "A"
    alias {
        name = "d3c22u04feroyw.cloudfront.net"
        zone_id = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
    }
}

resource "aws_route53_record" "a_www_akerl_com" {
    zone_id = "${module.akerl_com.zone_id}"
    name = "www.akerl.com"
    type = "A"
    alias {
        name = "d3c22u04feroyw.cloudfront.net"
        zone_id = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
    }
}
