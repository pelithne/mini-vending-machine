resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  provider                  = azurerm.spoke
  name                      = "${var.spoke_virtual_network_name}-to-${var.hub_virtual_network_name}"
  resource_group_name       = var.spoke_resource_group_name
  virtual_network_name      = var.spoke_virtual_network_name
  remote_virtual_network_id = var.hub_virtual_network_id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
}

resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  provider                  = azurerm.hub
  name                      = "${var.hub_virtual_network_name}-to-${var.spoke_virtual_network_name}"
  resource_group_name       = var.hub_resource_group_name
  virtual_network_name      = var.hub_virtual_network_name
  remote_virtual_network_id = var.spoke_virtual_network_id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
}