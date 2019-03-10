data "aws_iam_policy_document" "assume_admin" {
  statement {
    actions   = ["sts:AssumeRole"]
    resources = ["${aws_iam_role.admin.arn}"]

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

resource "aws_iam_policy" "assume_admin" {
  name   = "AssumeAdmin"
  policy = "${data.aws_iam_policy_document.assume_admin.json}"
}

resource "aws_iam_group_policy_attachment" "assume_admin" {
  group      = "${aws_iam_group.admins.name}"
  policy_arn = "${aws_iam_policy.assume_admin.arn}"
}

resource "aws_iam_group" "admins" {
  name = "admins"
}
