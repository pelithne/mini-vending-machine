output "vnet_name" {
  description = "The name of the virtual network."
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "The ID of the virtual network."
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_ids" {
  description = "The IDs of the subnets."
  value       = [for subnet in azurerm_subnet.subnet : subnet.id]
}

output "route_table_ids" {
  description = "The IDs of the route tables."
  value       = [for rt in azurerm_route_table.udr : rt.id]
}