resource "aws_cloudwatch_metric_alarm" "billing-alarm" {
  alarm_name          = "billing-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "21600"
  statistic           = "Maximum"
  threshold           = "20"

  dimensions {
    Currency = "USD"
  }

  alarm_description         = "Check for billing spikes"
  alarm_actions             = ["${module.sns-to-slack.sns-topic-arn}"]
  insufficient_data_actions = ["${module.sns-to-slack.sns-topic-arn}"]
}

module "sns-to-slack" {
  source         = "../modules/sns-to-slack"
  topic          = "billing-alarm"
  config-bucket  = "akerl-billing-alarm"
  logging-bucket = "${aws_s3_bucket.logging.id}"
}
