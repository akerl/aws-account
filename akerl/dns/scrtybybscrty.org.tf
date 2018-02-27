module "scrtybybscrty_org" {
  source            = "../../modules/domain"
  domain_name       = "scrtybybscrty.org"
  delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

resource "aws_route53_record" "a_scrtybybscrty_org" {
  zone_id = "${module.scrtybybscrty_org.zone_id}"
  name    = "scrtybybscrty.org"
  type    = "A"

  alias {
    name                   = "${var.akerl-blog-redirect-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_www_scrtybybscrty_org" {
  zone_id = "${module.scrtybybscrty_org.zone_id}"
  name    = "www.scrtybybscrty.org"
  type    = "A"

  alias {
    name                   = "${var.akerl-blog-redirect-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_repo_scrtybybscrty_org" {
  zone_id = "${module.scrtybybscrty_org.zone_id}"
  name    = "repo.scrtybybscrty.org"
  type    = "A"

  alias {
    name                   = "${var.amylum-repo-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}
