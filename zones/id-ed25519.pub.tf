module "id_ed25519_pub" {
    source = "./domain"
    domain_name = "id_ed25519.pub"
    delegation_set_id = "${aws_route53_delegation_set.main.id}"
    root_ipv4 = "97.107.129.127"
    root_ipv6 = "2600:3c03:e001:9001::9001"
}
