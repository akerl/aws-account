locals {
  records = {
    # 10.0.0.0/24 Infra
    "10.0.0.1"  = "gateway.infra.home"
    "10.0.0.2"  = "core.infra.home"
    "10.0.0.10" = "controller.infra.home"
    "10.0.0.20" = "switch0.infra.home"
    "10.0.0.21" = "switch1.infra.home"
    "10.0.0.22" = "switch2.infra.home"
    "10.0.0.40" = "wap0.infra.home"
    "10.0.0.41" = "wap1.infra.home"
    "10.0.0.42" = "wap2.infra.home"
    # 10.1.0.0/16 Lab
    # 10.2.0.0/24 Trusted
    # 172.16.0.0/22 IoT
    "172.16.0.10"  = "thermostat.iot.home"
    "172.16.0.11"  = "garage.iot.home"
    "172.16.0.20"  = "kitchenecho.iot.home"
    "172.16.0.21"  = "familyecho.iot.home"
    "172.16.0.22"  = "basementecho.iot.home"
    "172.16.0.30"  = "hello.iot.home"
    "172.16.0.31"  = "basementcam.iot.home"
    "172.16.0.100" = "printer.iot.home"
    "172.16.0.101" = "weather.iot.home"
    # 172.16.20.0/24 Gaming
    "172.16.20.20" = "ps4.gaming.home"
    # 192.168.0.0/24 Standard
    "192.168.0.20" = "szeth.standard.home"
    "192.168.0.21" = "lift.standard.home"
    "192.168.0.22" = "wrist.standard.home"
    "192.168.0.30" = "mazer.standard.home"
    "192.168.0.40" = "kellyphone.standard.home"
    "192.168.0.41" = "kellyipad.standard.home"
    # 192.168.99.0/24 Guest
  }
}

module "a-rwx_org" {
  source            = "armorfret/r53-zone/aws"
  version           = "0.3.2"
  admin_email       = var.admin_email
  domain_name       = "a-rwx.org"
  delegation_set_id = aws_route53_delegation_set.main.id
}

resource "aws_route53_record" "a_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "a-rwx.org"
  type    = "A"

  alias {
    name                   = var.akerl-blog-redirect_dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_www_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "www.a-rwx.org"
  type    = "A"

  alias {
    name                   = var.akerl-blog-redirect_dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cname_home_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "home.a-rwx.org"
  type    = "CNAME"
  ttl     = "60"
  records = ["akerl.dyndns.org"]
}

resource "aws_route53_record" "gateway_infra_home_a-rwx_org" {
  for_each = local.records
  zone_id  = module.a-rwx_org.zone_id
  name     = "${each.value}.a-rwx.org"
  type     = "A"
  ttl      = "60"
  records  = [each.key]
}

resource "aws_route53_delegation_set" "controller" {
  reference_name = "controller"
}

# this is necessary for LetsEncrypt cert validation
module "controller_infra_home_certs_a-rwx_org" {
  source            = "armorfret/r53-zone/aws"
  version           = "0.3.2"
  admin_email       = var.admin_email
  domain_name       = "controller.infra.home.certs.a-rwx.org"
  delegation_set_id = aws_route53_delegation_set.controller.id
}

resource "aws_route53_record" "ns_controller_infra_home_certs_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "controller.infra.home.certs.a-rwx.org"
  type    = "NS"
  ttl     = "60"
  records = aws_route53_delegation_set.controller.name_servers
}

resource "aws_route53_record" "caa_controller_infra_home_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "controller.infra.home.a-rwx.org"
  type    = "CAA"
  ttl     = "60"
  records = [
    "0 iodef \"mailto:admin@lesaker.org\"",
    "0 issuewild \";\"",
    "0 issue \"letsencrypt.org\"",
  ]
}

resource "aws_route53_record" "cname_acme_challenge_controller_infra_home_a-rwx_org" {
  zone_id = module.a-rwx_org.zone_id
  name    = "_acme-challenge.controller.infra.home.a-rwx.org"
  type    = "CNAME"
  ttl     = "60"
  records = ["_acme-challenge.controller.infra.home.certs.a-rwx.org"]
}

data "aws_iam_policy_document" "certbot_validation" {
  statement {
    actions = [
      "route53:ListHostedZones",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "route53:GetHostedZone",
      "route53:ListResourceRecordSets",
      "route53:ChangeResourceRecordSets",
    ]

    resources = [
      "arn:aws:route53:::hostedzone/${module.controller_infra_home_certs_a-rwx_org.zone_id}",
    ]
  }
}

resource "aws_iam_user_policy" "certbot_validation" {
  name   = "controller_certbot_validation"
  user   = aws_iam_user.controller_certbot.name
  policy = data.aws_iam_policy_document.certbot_validation.json
}

resource "awscreds_iam_access_key" "controller_certbot" {
  user = aws_iam_user.controller_certbot.name
  file = "creds/${aws_iam_user.controller_certbot.name}"
}

resource "aws_iam_user" "controller_certbot" {
  name = "controller_certbot"
}
