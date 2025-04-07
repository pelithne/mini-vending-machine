output "role_assignment_ids" {
  description = "A list of role assignment IDs"
  value       = [for v in azurerm_role_assignment.role_assignment : v.id]
}

output "debug_principal_ids" {
  value = local.principal_ids
}