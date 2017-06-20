module "a-rwx_org" {
  source            = "./domain"
  domain_name       = "a-rwx.org"
  delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

resource "aws_route53_record" "a_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "a-rwx.org"
  type    = "A"

  alias {
    name                   = "d3c22u04feroyw.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_www_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "www.a-rwx.org"
  type    = "A"

  alias {
    name                   = "d3c22u04feroyw.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_osquery-c6_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "osquery-c6.a-rwx.org"
  type    = "A"
  ttl     = "86400"
  records = ["45.79.181.133"]
}

resource "aws_route53_record" "a_osquery-c7_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "osquery-c7.a-rwx.org"
  type    = "A"
  ttl     = "86400"
  records = ["104.200.28.22"]
}

resource "aws_route53_record" "a_osquery-ubuntu_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "osquery-ubuntu.a-rwx.org"
  type    = "A"
  ttl     = "86400"
  records = ["104.200.28.27"]
}

resource "aws_route53_record" "a_osquery-arch_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "osquery-arch.a-rwx.org"
  type    = "A"
  ttl     = "86400"
  records = ["104.200.28.35"]
}
