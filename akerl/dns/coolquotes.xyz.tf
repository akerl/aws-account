module "coolquotes_xyz" {
  source            = "../../modules/domain"
  domain_name       = "coolquotes.xyz"
  delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

resource "aws_route53_record" "a_auth_coolquotes_xyz" {
  zone_id = "${module.coolquotes_xyz.zone_id}"

  name = "auth.coolquotes.xyz"
  type = "A"

  alias {
    name                   = "${var.akerl-quote-auth-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
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

resource "aws_route53_record" "a_books_coolquotes_xyz" {
  zone_id = "${module.coolquotes_xyz.zone_id}"

  name = "books.coolquotes.xyz"
  type = "A"

  alias {
    name                   = "${var.akerl-books-library-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_dcs_coolquotes_xyz" {
  zone_id = "${module.coolquotes_xyz.zone_id}"

  name = "dcs.coolquotes.xyz"
  type = "A"

  alias {
    name                   = "${var.akerl-dcs-library-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}
