module "coolquotes_xyz" {
  source            = "./domain"
  domain_name       = "coolquotes.xyz"
  delegation_set_id = "${aws_route53_delegation_set.main.id}"
}
