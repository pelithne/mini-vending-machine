# Combine the provided object_id into a map for iteration
locals {
  principal_ids = { "principal" = var.object_id }
}

# Role assignment
resource "azurerm_role_assignment" "role_assignment" {
  for_each            = local.principal_ids
  scope               = var.scope
  role_definition_name = var.role_definition_name
  principal_id        = each.value
}