resource "aws_lambda_permission" "allow_cloudwatch" {
  function_name = "${aws_lambda_function.lambda.function_name}"
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.cron.arn}"
}

resource "aws_cloudwatch_event_rule" "cron" {
  name                = "hookshot_${var.data-bucket}_cron"
  description         = "Launch lambda"
  schedule_expression = "rate(${var.rate})"
}

resource "aws_cloudwatch_event_target" "cron" {
  rule      = "${aws_cloudwatch_event_rule.cron.name}"
  target_id = "invoke_hookshot"
  arn       = "${aws_lambda_function.lambda.arn}"
}
