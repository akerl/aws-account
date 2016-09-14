resource "aws_cloudwatch_metric_alarm" "billing-alarm" {
    alarm_name = "billing-alarm"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods = "2"
    metric_name = "EstimatedCharges"
    namespace = "AWS/Billing"
    period = "3600"
    statistic = "Maximum"
    threshold = "10"
    dimensions {
        Currency = "USD"
    }
    alarm_description = "Check for billing spikes"
    alarm_actions = ["${aws_sns_topic.billing-notif.arn}"]
}

resource "aws_sns_topic" "billing-notif" {
  name = "billing-notif"
}
