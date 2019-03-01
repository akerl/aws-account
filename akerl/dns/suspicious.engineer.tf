module "suspicious_engineer" {
  source            = "github.com/armorfret/terraform-aws-r53-zone"
  admin_email       = "${var.admin_email}"
  domain_name       = "suspicious.engineer"
  delegation_set_id = "${aws_route53_delegation_set.main.id}"
}
