module "happilyeveraker_com" {
    source = "./domain"
    domain_name = "happilyeveraker.com"
    delegation_set_id = "${aws_route53_delegation_set.main.id}"
    root_ipv4 = "70.85.129.127"
    root_ipv6 = "2600:3c00:e001:9001::1"
}
