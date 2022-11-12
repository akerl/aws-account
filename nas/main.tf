terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

    awscreds = {
      source  = "armorfret/awscreds"
      version = "~> 0.6"
    }
  }
}

resource "aws_ses_domain_identity" "this" {
  domain = "a-rwx.org"
}

resource "aws_route53_record" "verification" {
  zone_id = "Z1GSN0DUY7LO3I"
  name    = "_amazonses.${aws_ses_domain_identity.this.domain}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.this.verification_token]
}

resource "aws_ses_domain_dkim" "this" {
  domain = aws_ses_domain_identity.this.domain
}

resource "aws_route53_record" "dkim" {
  count   = 3
  zone_id = aws_route53_record.verification.zone_id
  name    = "${element(aws_ses_domain_dkim.this.dkim_tokens, count.index)}._domainkey"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.this.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

data "aws_iam_policy_document" "ses_policy" {
  statement {
    actions   = ["ses:SendRawEmail"]
    resources = [aws_ses_domain_identity.this.arn]
  }
}

resource "awscreds_iam_access_key" "this" {
  user = aws_iam_user.this.name
  file = "creds/${aws_iam_user.this.name}"
}

resource "aws_iam_user" "this" {
  name = "ses-sender"
}

resource "aws_iam_user_policy" "send_emails" {
  policy = data.aws_iam_policy_document.ses_policy.json
  user   = aws_iam_user.this.name
}
