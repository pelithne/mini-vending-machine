resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-alz-${var.environment}-${var.location}-${format("%03d", var.serial)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}

resource "azurerm_subnet" "subnet" {
  count               = length(var.subnets)
  name                = var.subnets[count.index].name
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes    = var.subnets[count.index].address_prefixes
}

resource "azurerm_route_table" "udr" {
  count               = length(var.route_tables)
  name                = var.route_tables[count.index].name
  location            = var.location
  resource_group_name = var.resource_group_name

  route {
    name                   = var.route_tables[count.index].route.name
    address_prefix         = var.route_tables[count.index].route.address_prefix
    next_hop_type          = var.route_tables[count.index].route.next_hop_type
    next_hop_in_ip_address = var.route_tables[count.index].route.next_hop_in_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "subnet_rt_association" {
  count          = length(var.subnets)
  subnet_id      = azurerm_subnet.subnet[count.index].id
  route_table_id = azurerm_route_table.udr[count.index % length(var.route_tables)].id
}