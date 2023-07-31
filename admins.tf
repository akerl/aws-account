resource "aws_iam_account_password_policy" "strict" { #tfsec:ignore:aws-iam-set-max-password-age
  minimum_password_length        = 32
  password_reuse_prevention      = 24
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
}

resource "aws_iam_user" "admins" {
  name  = var.admins[count.index]
  count = length(var.admins)
}

resource "aws_iam_group_membership" "admins" {
  name       = "admins"
  users      = var.admins
  group      = aws_iam_group.admins.name
  depends_on = [aws_iam_user.admins]
}

resource "awscreds_iam_access_key" "admins" {
  user       = var.admins[count.index]
  file       = "creds/account-admins-${var.admins[count.index]}"
  count      = length(var.admins)
  depends_on = [aws_iam_user.admins]
}

data "aws_iam_policy_document" "assume_admin" {
  statement {
    actions   = ["sts:AssumeRole"]
    resources = [aws_iam_role.admin.arn]

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

resource "aws_iam_policy" "assume_admin" {
  name   = "AssumeAdmin"
  policy = data.aws_iam_policy_document.assume_admin.json
}

resource "aws_iam_group_policy_attachment" "assume_admin" {
  group      = aws_iam_group.admins.name
  policy_arn = aws_iam_policy.assume_admin.arn
}

resource "aws_iam_group" "admins" {
  name = "admins"
}

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
