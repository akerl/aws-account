output "domains" {
  value = var.domains
}

output "nameservers" {
  value = aws_route53_delegation_set.main.name_servers
}
