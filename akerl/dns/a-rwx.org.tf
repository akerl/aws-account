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

resource "aws_route53_record" "a_alfa_internal_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "alfa.internal.a-rwx.org"
  type    = "A"
  ttl     = "86400"
  records = ["10.1.1.1"]
}

resource "aws_route53_record" "a_alfa-ipmi_internal_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "alfa-ipmi.internal.a-rwx.org"
  type    = "A"
  ttl     = "86400"
  records = ["10.0.1.1"]
}

resource "aws_route53_record" "a_bravo_internal_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "bravo.internal.a-rwx.org"
  type    = "A"
  ttl     = "86400"
  records = ["10.1.1.2"]
}

resource "aws_route53_record" "a_bravo-ipmi_internal_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "bravo-ipmi.internal.a-rwx.org"
  type    = "A"
  ttl     = "86400"
  records = ["10.0.1.2"]
}

resource "aws_route53_record" "a_charlie_internal_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "charlie.internal.a-rwx.org"
  type    = "A"
  ttl     = "86400"
  records = ["10.1.1.3"]
}

resource "aws_route53_record" "a_charlie-ipmi_internal_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "charlie-ipmi.internal.a-rwx.org"
  type    = "A"
  ttl     = "86400"
  records = ["10.0.1.3"]
}

resource "aws_route53_record" "a_delta_internal_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "delta.internal.a-rwx.org"
  type    = "A"
  ttl     = "86400"
  records = ["10.1.1.4"]
}

resource "aws_route53_record" "a_delta-ipmi_internal_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "delta-ipmi.internal.a-rwx.org"
  type    = "A"
  ttl     = "86400"
  records = ["10.0.1.4"]
}

resource "aws_route53_record" "a_echo_internal_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "echo.internal.a-rwx.org"
  type    = "A"
  ttl     = "86400"
  records = ["10.1.1.5"]
}

resource "aws_route53_record" "a_echo-ipmi_internal_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "echo-ipmi.internal.a-rwx.org"
  type    = "A"
  ttl     = "86400"
  records = ["10.0.1.5"]
}

resource "aws_route53_record" "a_foxtrot_internal_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "foxtrot.internal.a-rwx.org"
  type    = "A"
  ttl     = "86400"
  records = ["10.1.1.6"]
}

resource "aws_route53_record" "a_foxtrot-ipmi_internal_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "foxtrot-ipmi.internal.a-rwx.org"
  type    = "A"
  ttl     = "86400"
  records = ["10.0.1.6"]
}

resource "aws_route53_record" "a_edge_internal_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "edge.internal.a-rwx.org"
  type    = "A"
  ttl     = "86400"
  records = ["10.0.0.1"]
}

resource "aws_route53_record" "a_switch1_internal_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "switch1.internal.a-rwx.org"
  type    = "A"
  ttl     = "86400"
  records = ["10.0.0.2"]
}

resource "aws_route53_record" "a_jump_internal_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "jump.internal.a-rwx.org"
  type    = "A"
  ttl     = "86400"
  records = ["10.2.0.1"]
}

resource "aws_route53_record" "a_infra_internal_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "infra.internal.a-rwx.org"
  type    = "A"
  ttl     = "86400"
  records = ["10.0.0.100"]
}

