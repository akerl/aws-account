resource "aws_budgets_budget" "cost" {
  name              = "cost_budget"
  budget_type       = "COST"
  limit_amount      = "50.0"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = "2017-01-01_00:00"

  cost_types {
    include_other_subscription = false
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = [var.billing_email]
  }
}

