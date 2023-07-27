resource "aws_route53_record" "a_kellywatts_com" {
  zone_id = module.zones["kellywatts.com"].zone_id
  name    = "kellywatts.com"
  type    = "A"
  ttl     = "86400"
  records = ["66.6.44.4"]
}

resource "aws_route53_record" "cname_www_kellywatts_com" {
  zone_id = module.zones["kellywatts.com"].zone_id
  name    = "www.kellywatts.com"
  type    = "CNAME"
  ttl     = "86400"
  records = ["domains.tumblr.com."]
}
