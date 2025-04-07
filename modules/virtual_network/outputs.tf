output "vnet_name" {
  description = "The name of the virtual network."
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "The ID of the virtual network."
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_id" {
  description = "The ID of the created subnet"
  value       = azurerm_subnet.subnet.id
}

output "route_table_id" {
  description = "The ID of the created route table"
  value       = azurerm_route_table.udr.id
}