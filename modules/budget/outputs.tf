output "budget_id" {
  value       = azurerm_consumption_budget_subscription.subscription_budget.id
  description = "The ID of the created Azure budget."
}