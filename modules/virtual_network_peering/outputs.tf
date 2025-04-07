output "spoke_to_hub_id" {
  description = "The ID of the peering from spoke to hub."
  value       = azurerm_virtual_network_peering.spoke_to_hub.id
}

output "hub_to_spoke_id" {
  description = "The ID of the peering from hub to spoke."
  value       = azurerm_virtual_network_peering.hub_to_spoke.id
}