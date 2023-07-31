resource "aws_ses_domain_identity" "nas" {
  domain = "a-rwx.org"
}

resource "aws_route53_record" "nas_verification" {
  zone_id = "Z06324102J3IVSSCKNZ4A"
  name    = "_amazonses.${aws_ses_domain_identity.nas.domain}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.nas.verification_token]
}

resource "aws_ses_domain_dkim" "nas" {
  domain = aws_ses_domain_identity.nas.domain
}

resource "aws_route53_record" "nas_dkim" {
  count   = 3
  zone_id = aws_route53_record.nas_verification.zone_id
  name    = "${element(aws_ses_domain_dkim.nas.dkim_tokens, count.index)}._domainkey"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.nas.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

data "aws_iam_policy_document" "nas_ses_policy" {
  statement {
    actions   = ["ses:SendRawEmail"]
    resources = [aws_ses_domain_identity.nas.arn]
  }
}

resource "awscreds_iam_access_key" "nas" {
  user = aws_iam_user.nas.name
  file = "creds/${aws_iam_user.nas.name}"
}

resource "aws_iam_user" "nas" { #tfsec:ignore:aws-iam-no-user-attached-policies
  name = "ses-sender"
}

resource "aws_iam_user_policy" "nas_send_emails" {
  policy = data.aws_iam_policy_document.nas_ses_policy.json
  user   = aws_iam_user.nas.name
}
