resource "aws_api_gateway_account" "account" {
  cloudwatch_role_arn = aws_iam_role.apigw_cloudwatch.arn
}

resource "aws_iam_role_policy" "apigw_cloudwatch" {
  name   = "apigw_cloudwatch"
  role   = aws_iam_role.apigw_cloudwatch.name
  policy = data.aws_iam_policy_document.apigw_cloudwatch_perms.json
}

resource "aws_iam_role" "apigw_cloudwatch" {
  name               = "apigw_cloudwatch"
  assume_role_policy = data.aws_iam_policy_document.apigw_cloudwatch_assume.json
}

data "aws_iam_policy_document" "apigw_cloudwatch_assume" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "apigateway.amazonaws.com",
      ]
    }
  }
}

data "aws_iam_policy_document" "apigw_cloudwatch_perms" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:FilterLogEvents",
      "logs:GetLogEvents",
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }
}

