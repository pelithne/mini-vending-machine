locals {
  now        = timestamp()
  year       = tonumber(formatdate("YYYY", local.now))
  month      = tonumber(formatdate("MM", local.now))
  start_date = format("%04d-%02d-01T00:00:00Z", local.year, local.month)
  end_date   = format("%04d-%02d-01T00:00:00Z", local.year + 10, local.month)
}

resource "azurerm_consumption_budget_subscription" "subscription_budget" {
  name            = var.budget_name
  subscription_id = var.subscription_id
  amount          = var.amount
  time_grain      = "Monthly"

  time_period {
    start_date = local.start_date
    end_date   = local.end_date
  }

  dynamic "notification" {
    for_each = var.notification_emails
    content {
      enabled        = true
      threshold      = notification.value.threshold
      operator       = notification.value.operator
      contact_emails = notification.value.emails
    }
  }
}