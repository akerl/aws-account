module "id-ed25519_pub" {
  source            = "github.com/armorfret/terraform-aws-r53-zone"
  admin_email       = "${var.admin_email}"
  domain_name       = "id-ed25519.pub"
  delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

resource "aws_route53_record" "a_id-ed25519_pub" {
  zone_id = "${module.id-ed25519_pub.zone_id}"
  name    = "id-ed25519.pub"
  type    = "A"

  alias {
    name                   = "${var.akerl-keys-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}
