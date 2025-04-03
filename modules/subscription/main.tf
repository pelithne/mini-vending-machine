resource "azurerm_subscription" "example" {
  billing_scope_id        = var.billing_scope_id
  subscription_name       = var.subscription_name
  subscription_alias_name = var.subscription_alias_name
  display_name            = var.display_name
}

data "azuread_user" "contributor" {
  user_principal_name = var.contributor_email
}

resource "azurerm_role_assignment" "contributor_assignment" {
  scope                = "/subscriptions/${azurerm_subscription.example.subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = data.azuread_user.contributor.id
}

output "subscription_id" {
  value = azurerm_subscription.example.subscription_id
}