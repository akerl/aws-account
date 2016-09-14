resource "aws_iam_user" "circleci" {
    name = "akerl-dns-circleci"
}

data "aws_iam_policy_document" "dnsupdater" {
    statement {
        actions = [
            "route53:CreateHostedZone",
            "route53:UpdateHostedZoneComment",
            "route53:CreateReusableDelegationSet",
            "route53:ChangeResourceRecordSets",
            "route53:ChangeTagsForResource",
            "route53:List*",
            "route53:Get*",
        ]
        resources = [
            "arn:aws:route53:::*",
        ]
    }
}

resource "aws_iam_user_policy" "dnsupdater" {
    name = "dnsupdater"
    user = "${aws_iam_user.circleci.name}"
    policy = "${data.aws_iam_policy_document.dnsupdater.json}"
}

resource "awscreds_iam_access_key" "circleci-key" {
    user = "${aws_iam_user.circleci.name}"
    file = "creds/akerl-dns-circleci"
}
