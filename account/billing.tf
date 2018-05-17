resource "aws_budgets_budget" "cost" {
  name              = "cost_budget"
  budget_type       = "COST"
  limit_amount      = "10"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = "2017-01-01_00:00"
  cost_types {
    include_other_subscription = false
  }
}
