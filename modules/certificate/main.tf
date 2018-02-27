variable "domains" {
  type = "list"
}

output "arn" {
  value = "${aws_acm_certificate_validation.certificate.certificate_arn}"
}

resource "aws_acm_certificate" "certificate" {
  domain_name = "${var.domains[0]}"
  subject_alternative_names = "${slice(var.domains, 1, length(var.domains))}"
  validation_method = "DNS"
}

data "aws_route53_zone" "zone" {
  count = "${length(var.domains)}"
  name = "${replace(var.domains[count.index], "/^(?:.*\\.)?([^.]+\\.[^.]+)$/", "$1")}"
  private_zone = false
}

resource "aws_route53_record" "validation" {
  count   = "${length(var.domains)}"
  zone_id = "${data.aws_route53_zone.zone.*.id[count.index]}"

  name    = "${lookup(aws_acm_certificate.certificate.domain_validation_options[count.index], "resource_record_name")}"
  type    = "${lookup(aws_acm_certificate.certificate.domain_validation_options[count.index], "resource_record_type")}"
  records = ["${lookup(aws_acm_certificate.certificate.domain_validation_options[count.index], "resource_record_value")}"]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "certificate" {
  certificate_arn         = "${aws_acm_certificate.certificate.arn}"
  validation_record_fqdns = ["${aws_route53_record.validation.*.fqdn}"]
}
