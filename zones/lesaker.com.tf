module "lesaker_com" {
    source = "./domain"
    domain_name = "lesaker.com"
    delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

resource "aws_route53_record" "a_lesaker_com" {
    zone_id = "${module.lesaker_com.zone_id}"
    name = "lesaker.com"
    type = "A"
    alias {
        name = "d3c22u04feroyw.cloudfront.net"
        zone_id = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
    }
}

resource "aws_route53_record" "a_www_lesaker_com" {
    zone_id = "${module.lesaker_com.zone_id}"
    name = "www.lesaker.com"
    type = "A"
    alias {
        name = "d3c22u04feroyw.cloudfront.net"
        zone_id = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
    }
}
