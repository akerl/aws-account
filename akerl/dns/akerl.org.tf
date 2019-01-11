module "akerl_org" {
  source            = "github.com/armorfret/terraform-aws-r53-zone"
  admin_email       = "${var.admin_email}"
  domain_name       = "akerl.org"
  delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

resource "aws_route53_record" "a_akerl_org" {
  zone_id = "${module.akerl_org.zone_id}"
  name    = "akerl.org"
  type    = "A"

  alias {
    name                   = "${var.akerl-blog-redirect-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_www_akerl_org" {
  zone_id = "${module.akerl_org.zone_id}"
  name    = "www.akerl.org"
  type    = "A"

  alias {
    name                   = "${var.akerl-blog-redirect-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_blog_akerl_org" {
  zone_id = "${module.akerl_org.zone_id}"
  name    = "blog.akerl.org"
  type    = "A"

  alias {
    name                   = "${var.akerl-blog-dns-name}"
    zone_id                = "${var.cloudfront-zone-id}"
    evaluate_target_health = false
  }
}
