data "aws_caller_identity" "account_info" {
}

data "aws_iam_policy_document" "admin_trust" {
  statement {
    actions = ["sts:AssumeRole"]

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.account_info.account_id}:root"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "admin_access" {
  role       = aws_iam_role.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role" "admin" {
  name               = "admin"
  assume_role_policy = data.aws_iam_policy_document.admin_trust.json
}

