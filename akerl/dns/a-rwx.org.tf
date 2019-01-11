module "a-rwx_org" {
  source            = "github.com/armorfret/terraform-aws-r53-zone"
  admin_email       = "${var.admin_email}"
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

resource "aws_route53_record" "macrepo_halyard_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "macrepo.halyard.a-rwx.org"
  type    = "A"
  ttl     = "60"
  records = ["97.107.135.32"]
}

resource "aws_route53_record" "caa_macrepo_halyard_a-rwx_org" {
  zone_id = "${module.a-rwx_org.zone_id}"
  name    = "macrepo.halyard.a-rwx.org"
  type    = "CAA"
  ttl     = "60"

  records = [
    "0 issue \"letsencrypt.org\"",
    "0 issuewild \";\"",
  ]
}
