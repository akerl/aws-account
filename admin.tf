resource "aws_iam_group" "admins" {
    name = "admins"
}

resource "aws_iam_group_policy_attachment" "test-attach" {
    group = "${aws_iam_group.admins.name}"
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "akerl" {
    name = "akerl"
}

resource "aws_iam_group_membership" "admins" {
    name = "admins"
    users = ["${aws_iam_user.akerl.name}"]
    group = "${aws_iam_group.admins.name}"
}

resource "awscreds_iam_access_key" "akerl" {
    user = "${aws_iam_user.akerl.name}"
    file = "creds/akerl"
}
