module "id-ed25519_pub" {
  source            = "../../modules/domain"
  domain_name       = "id-ed25519.pub"
  delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

resource "aws_route53_record" "a_id-ed25519_pub" {
  zone_id = "${module.id-ed25519_pub.zone_id}"
  name    = "id-ed25519.pub"
  type    = "A"

  alias {
    name                   = "${var.keys-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}
