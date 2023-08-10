resource "aws_iam_user" "grafana" { #trivy:ignore:AVD-AWS-0143
  name = "grafana"
}

data "aws_iam_policy_document" "grafana-cloudwatch" {
  statement {
    sid = "readMetrics"

    actions = [
      "cloudwatch:DescribeAlarmsForMetric",
      "cloudwatch:DescribeAlarmHistory",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:ListMetrics",
      "cloudwatch:GetMetricData",
      "cloudwatch:GetInsightRuleReport",
    ]

    resources = [
      "*",
    ]

  }
  statement {
    sid = "readLogs"
    actions = [
      "logs:DescribeLogGroups",
      "logs:GetLogGroupFields",
      "logs:StartQuery",
      "logs:StopQuery",
      "logs:GetQueryResults",
      "logs:GetLogEvents",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = "readTags"

    actions = [
      "ec2:DescribeTags",
      "ec2:DescribeInstances",
      "ec2:DescribeRegions",
      "tag:GetResources",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_user_policy" "grafana-cloudwatch" {
  name   = "grafana-cloudwatch"
  user   = aws_iam_user.grafana.name
  policy = data.aws_iam_policy_document.grafana-cloudwatch.json
}

resource "awscreds_iam_access_key" "grafana" {
  user = aws_iam_user.grafana.name
  file = "creds/${aws_iam_user.grafana.name}"
}

