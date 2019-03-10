module "coolquotes_xyz" {
  source            = "armorfret/r53-zone/aws"
  version           = "0.0.2"
  admin_email       = "${var.admin_email}"
  domain_name       = "coolquotes.xyz"
  delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

resource "aws_route53_record" "a_auth_coolquotes_xyz" {
  zone_id = "${module.coolquotes_xyz.zone_id}"

  name = "auth.coolquotes.xyz"
  type = "A"

  alias {
    name                   = "${var.akerl-quote-auth-dns_name}"
    zone_id                = "${var.cloudfront_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_hf_coolquotes_xyz" {
  zone_id = "${module.coolquotes_xyz.zone_id}"

  name = "hf.coolquotes.xyz"
  type = "A"

  alias {
    name                   = "${var.akerl-hf-library-dns_name}"
    zone_id                = "${var.cloudfront_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_books_coolquotes_xyz" {
  zone_id = "${module.coolquotes_xyz.zone_id}"

  name = "books.coolquotes.xyz"
  type = "A"

  alias {
    name                   = "${var.akerl-books-library-dns_name}"
    zone_id                = "${var.cloudfront_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_dcs_coolquotes_xyz" {
  zone_id = "${module.coolquotes_xyz.zone_id}"

  name = "dcs.coolquotes.xyz"
  type = "A"

  alias {
    name                   = "${var.akerl-dcs-library-dns_name}"
    zone_id                = "${var.cloudfront_zone_id}"
    evaluate_target_health = false
  }
}
