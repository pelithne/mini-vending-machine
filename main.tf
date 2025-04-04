terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.50"
    }
  }
}

provider "azurerm" {
  alias  = "spoke"
  subscription_id = "658cd127-a693-4622-85be-4c340afdc81a"
  features {}
}

provider "azurerm" {
  alias  = "hub"
  subscription_id = "6e2cc04e-7586-4343-86e1-e78513de21d6"
  features {}
}

resource "azurerm_resource_group" "spoke_rg" {
  provider = azurerm.spoke
  name     = "spoke-rg"
  location = "swedencentral"
}

resource "azurerm_virtual_network" "spoke_vnet" {
  provider            = azurerm.spoke
  name                = "spoke-vnet"
  location            = azurerm_resource_group.spoke_rg.location
  resource_group_name = azurerm_resource_group.spoke_rg.name
  address_space       = ["10.2.0.0/16"]

  depends_on = [
    azurerm_resource_group.spoke_rg
  ]
}

resource "azurerm_route_table" "spoke_rt" {
  provider            = azurerm.spoke
  name                = "spoke-route-table"
  location            = azurerm_resource_group.spoke_rg.location
  resource_group_name = azurerm_resource_group.spoke_rg.name

  route {
    name                   = "default-route"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.1.0.99"
  }

  depends_on = [
    azurerm_resource_group.spoke_rg
  ]
}

resource "azurerm_subnet" "spoke_subnet" {
  provider                 = azurerm.spoke
  name                     = "spoke-subnet"
  resource_group_name      = azurerm_resource_group.spoke_rg.name
  virtual_network_name     = azurerm_virtual_network.spoke_vnet.name
  address_prefixes         = ["10.2.1.0/24"]

  depends_on = [
    azurerm_virtual_network.spoke_vnet
  ]
}

resource "azurerm_subnet_route_table_association" "spoke_subnet_rt_association" {
  provider       = azurerm.spoke
  subnet_id      = azurerm_subnet.spoke_subnet.id
  route_table_id = azurerm_route_table.spoke_rt.id

  depends_on = [
    azurerm_subnet.spoke_subnet,
    azurerm_route_table.spoke_rt
  ]
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  provider                  = azurerm.spoke
  name                      = "spoke-to-hub"
  resource_group_name       = azurerm_resource_group.spoke_rg.name
  virtual_network_name      = azurerm_virtual_network.spoke_vnet.name
  remote_virtual_network_id = data.azurerm_virtual_network.hub_vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

  depends_on = [
    azurerm_resource_group.spoke_rg,
    azurerm_virtual_network.spoke_vnet
  ]
}

resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  provider                  = azurerm.hub
  name                      = "hub-to-spoke"
  resource_group_name       = data.azurerm_virtual_network.hub_vnet.resource_group_name
  virtual_network_name      = data.azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

  depends_on = [
    azurerm_resource_group.spoke_rg,
    azurerm_virtual_network.spoke_vnet
  ]
}

data "azurerm_virtual_network" "hub_vnet" {
  provider            = azurerm.hub
  name                = "hub_vnet"
  resource_group_name = "Default-ActivityLogAlerts"
}
