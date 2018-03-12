resource "aws_sns_topic" "topic" {
  name = "${var.topic}"
}

resource "aws_sns_topic_subscription" "sub" {
  topic_arn = "${aws_sns_topic.topic.arn}"
  protocol  = "lambda"
  endpoint  = "${aws_lambda_function.lambda.arn}"
}
