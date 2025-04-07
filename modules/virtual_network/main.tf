resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet.name
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet.address_prefix]
}

resource "azurerm_route_table" "udr" {
  name                = "${var.prefix}-udr"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  route {
    name                   = var.route.name
    address_prefix         = var.route.address_prefix
    next_hop_type          = var.route.next_hop_type
    next_hop_in_ip_address = var.route.next_hop_in_ip_address
  }
}