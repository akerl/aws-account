module "scrtybybscrty_org" {
  source            = "armorfret/r53-zone/aws"
  version           = "0.3.2"
  admin_email       = var.admin_email
  domain_name       = "scrtybybscrty.org"
  delegation_set_id = aws_route53_delegation_set.main.id
}

resource "aws_route53_record" "a_scrtybybscrty_org" {
  zone_id = module.scrtybybscrty_org.zone_id
  name    = "scrtybybscrty.org"
  type    = "A"

  alias {
    name                   = var.akerl-blog-redirect_dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_www_scrtybybscrty_org" {
  zone_id = module.scrtybybscrty_org.zone_id
  name    = "www.scrtybybscrty.org"
  type    = "A"

  alias {
    name                   = var.akerl-blog-redirect_dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_repo_scrtybybscrty_org" {
  zone_id = module.scrtybybscrty_org.zone_id
  name    = "repo.scrtybybscrty.org"
  type    = "A"

  alias {
    name                   = var.amylum-repo-dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_scratch_scrtybybscrty_org" {
  zone_id = module.scrtybybscrty_org.zone_id
  name    = "scratch.scrtybybscrty.org"
  type    = "A"

  alias {
    name                   = var.akerl-scratch-dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_littlesnitch_scrtybybscrty_org" {
  zone_id = module.scrtybybscrty_org.zone_id
  name    = "littlesnitch.scrtybybscrty.org"
  type    = "A"

  alias {
    name                   = var.akerl-littlesnitch-rules-dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_auth_scrtybybscrty_org" {
  zone_id = module.scrtybybscrty_org.zone_id
  name    = "auth.scrtybybscrty.org"
  type    = "A"

  alias {
    name                   = var.akerl-private-auth-dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_files_scrtybybscrty_org" {
  zone_id = module.scrtybybscrty_org.zone_id
  name    = "files.scrtybybscrty.org"
  type    = "A"

  alias {
    name                   = var.akerl-private-files-dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "ns_wg_scrtybybscrty_org" {
  zone_id = module.scrtybybscrty_org.zone_id
  name    = "wg.scrtybybscrty.org"
  type    = "NS"
  ttl     = "86400"

  records = [
    "ns1.linode.com",
    "ns2.linode.com",
    "ns3.linode.com",
    "ns4.linode.com",
    "ns5.linode.com",
  ]
}

resource "aws_route53_record" "ns_mc_scrtybybscrty_org" {
  zone_id = module.scrtybybscrty_org.zone_id
  name    = "mc.scrtybybscrty.org"
  type    = "NS"
  ttl     = "86400"

  records = [
    "ns1.linode.com",
    "ns2.linode.com",
    "ns3.linode.com",
    "ns4.linode.com",
    "ns5.linode.com",
  ]
}
