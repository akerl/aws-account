data "aws_iam_policy_document" "lambda_assume" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "lambda.amazonaws.com",
      ]
    }
  }
}

data "aws_iam_policy_document" "lambda_perms" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.data-bucket.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.data-bucket.id}",
    ]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }
}

resource "aws_iam_role_policy" "lambda_perms" {
  name   = "lambda_perms"
  role   = "${aws_iam_role.lambda.name}"
  policy = "${data.aws_iam_policy_document.lambda_perms.json}"
}

resource "aws_iam_role" "lambda" {
  name               = "hookshot_lambda"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_assume.json}"
}

resource "aws_lambda_function" "hookshot_lambda" {
  s3_bucket     = "${var.data-bucket}"
  s3_key        = "lambdas/payload-${chomp(file("${path.module}/version"))}.zip"
  function_name = "hookshot_lambda"
  role          = "${aws_iam_role.lambda.arn}"
  handler       = "handler.Handle"
  runtime       = "python2.7"
  timeout       = 50

  environment {
    variables = {
      S3_BUCKET = "${var.data-bucket}"
      S3_KEY    = "urls"
    }
  }
}

resource "aws_lambda_permission" "allow_api_gateway" {
  function_name = "${aws_lambda_function.hookshot_lambda.function_name}"
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.cron.arn}"
}

resource "aws_cloudwatch_event_rule" "cron" {
  name                = "hookshot_cron"
  description         = "Launch hookshot lambda"
  schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "cron" {
  rule      = "${aws_cloudwatch_event_rule.cron.name}"
  target_id = "invoke_hookshot"
  arn       = "${aws_lambda_function.hookshot_lambda.arn}"
}
