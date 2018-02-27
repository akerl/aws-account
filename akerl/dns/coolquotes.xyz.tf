module "coolquotes_xyz" {
  source            = "../../modules/domain"
  domain_name       = "coolquotes.xyz"
  delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

resource "aws_route53_record" "a_hf_coolquotes_xyz" {
  zone_id = "${module.coolquotes_xyz.zone_id}"

  name = "hf.coolquotes.xyz"
  type = "A"

  alias {
    name                   = "${var.akerl-hf-library-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}
