module "scrtybybscrty_org" {
  source            = "github.com/armorfret/terraform-aws-r53-zone"
  admin_email       = "${var.admin_email}"
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

resource "aws_route53_record" "a_scratch_scrtybybscrty_org" {
  zone_id = "${module.scrtybybscrty_org.zone_id}"
  name    = "scratch.scrtybybscrty.org"
  type    = "A"

  alias {
    name                   = "${var.akerl-scratch-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_littlesnitch-rules_scrtybybscrty_org" {
  zone_id = "${module.scrtybybscrty_org.zone_id}"
  name    = "littlesnitch.scrtybybscrty.org"
  type    = "A"

  alias {
    name                   = "${var.akerl-littlesnitch-rules-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}
