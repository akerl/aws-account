resource "aws_iam_role_policy" "lambda_perms" {
  name   = "lambda_perms"
  role   = "${aws_iam_role.lambda.name}"
  policy = "${data.aws_iam_policy_document.lambda_perms.json}"
}

resource "aws_iam_role" "lambda" {
  name               = "sns-to-slack_lambda_${var.config-bucket}"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_assume.json}"
}

resource "aws_lambda_function" "lambda" {
  s3_bucket     = "${var.lambda-bucket}"
  s3_key        = "lambdas/payload-${chomp(file("${path.module}/version"))}.zip"
  function_name = "sns-to-slack_lambda_${var.config-bucket}"
  role          = "${aws_iam_role.lambda.arn}"
  handler       = "main"
  runtime       = "go1.x"
  timeout       = 10

    environment {
    variables = {
      S3_BUCKET = "${var.config-bucket}"
      S3_KEY    = "config.yaml"
    }
  }
}

resource "aws_lambda_permission" "sns_notify" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda.function_name}"
  principal     = "sns.amazonaws.com"
  source_arn    = "${aws_sns_topic.topic.arn}"
}
