data "aws_caller_identity" "account_info" {}

data "aws_iam_policy_document" "admin-trust" {
  statement {
    actions = ["sts:AssumeRole"]

    #    condition {
    #      test = "Bool"
    #      variable = "aws:MultiFactorAuthPresent"
    #      value = "true"
    #    }
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.account_info.account_id}:root"]
    }
  }
}

resource "aws_iam_role" "admin" {
  name               = "admin"
  assume_role_policy = "${data.aws_iam_policy_document.admin-trust.json}"
}

resource "aws_iam_role_policy_attachment" "admin-access" {
  role       = "${aws_iam_role.admin.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group" "admins" {
  name = "admins"
}

resource "aws_iam_group_policy_attachment" "admin-access" {
  group      = "${aws_iam_group.admins.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "admin_users" {
  name  = "${element(var.admins, count.index)}"
  count = "${length(var.admins)}"
}

resource "aws_iam_group_membership" "admins" {
  name       = "admins"
  users      = "${var.admins}"
  group      = "${aws_iam_group.admins.name}"
  depends_on = ["aws_iam_user.admin_users"]
}

resource "awscreds_iam_access_key" "akerl" {
  user       = "${element(var.admins, count.index)}"
  file       = "creds/account-admins-${element(var.admins, count.index)}"
  count      = "${length(var.admins)}"
  depends_on = ["aws_iam_user.admin_users"]
}
