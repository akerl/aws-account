module "id-ed25519_pub" {
    source = "./domain"
    domain_name = "id-ed25519.pub"
    delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

resource "aws_route53_record" "a_id-ed25519_pub" {
    zone_id = "${module.id-ed25519_pub.zone_id}"
    name = "id-ed25519.pub"
    type = "A"
    alias {
        name = "d3c22u04feroyw.cloudfront.net"
        zone_id = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
    }
}

resource "aws_route53_record" "a_www_id-ed25519_pub" {
    zone_id = "${module.id-ed25519_pub.zone_id}"
    name = "www.id-ed25519.pub"
    type = "A"
    alias {
        name = "d3c22u04feroyw.cloudfront.net"
        zone_id = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
    }
}
