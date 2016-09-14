resource "aws_iam_group" "admins" {
    name = "admins"
}

resource "aws_iam_group_policy_attachment" "admin-access" {
    group = "${aws_iam_group.admins.name}"
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "admin_users" {
    name = "${element(var.admins, count.index)}"
    count = "${length(var.admins)}"
}

resource "aws_iam_group_membership" "admins" {
    name = "admins"
    users = "${var.admins}"
    group = "${aws_iam_group.admins.name}"
}

resource "awscreds_iam_access_key" "akerl" {
    user = "${element(var.admins, count.index)}"
    file = "creds/${element(var.admins, count.index)}"
    count = "${length(var.admins)}"
}
