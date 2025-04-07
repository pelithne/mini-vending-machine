output "name" {
  description = "The name of the resource group."
  value       = azurerm_resource_group.spoke_resource_group.name
}

output "location" {
  description = "The location of the resource group."
  value       = azurerm_resource_group.spoke_resource_group.location
}

output "environment" {
  description = "The environment for the resource group (e.g., dev, test, prod)."
  value       = var.environment
}

output "serial" {
  description = "The serial number for the resource group."
  value       = random_integer.resource_group_serial.result
}

