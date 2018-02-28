module "a-rwx_org" {
  source            = "../../modules/domain"
  domain_name       = "a-rwx.org"
  delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

resource "aws_route53_record" "a_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "a-rwx.org"
  type    = "A"

  alias {
    name                   = "${var.akerl-blog-redirect-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_www_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "www.a-rwx.org"
  type    = "A"

  alias {
    name                   = "${var.akerl-blog-redirect-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "text_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "text.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["50.116.51.105"]
}

resource "aws_route53_record" "caa_text_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "text.a-rwx.org"
  type    = "CAA"
  ttl     = "60"

  records = [
    "0 issue \"letsencrypt.org\"",
    "0 issuewild \";\"",
  ]
}
