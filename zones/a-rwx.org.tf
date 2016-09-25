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

resource "aws_route53_record" "a_olhado_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "olhado.a-rwx.org"
  type    = "A"
  ttl     = "86400"
  records = ["70.85.129.127"]
}

resource "aws_route53_record" "aaaa_olhado_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "olhado.a-rwx.org"
  type    = "AAAA"
  ttl     = "86400"
  records = ["2600:3c00:e001:9001::1"]
}
