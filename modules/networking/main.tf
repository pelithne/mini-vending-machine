provider "azurerm" {
  features {}
  // Optionally specify subscription_id dynamically
  subscription_id = var.subscription_id
}

// Create a resource group for the VNet
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
  tags     = var.common_tags
}

/*
// Create a Virtual Network Manager (optional, for IPAM)
resource "azurerm_virtual_network_manager" "vnm" {
  name                = "myVnetManager"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.common_tags
}
*/

// Create the NSG
resource "azurerm_network_security_group" "nsg" {
  name                = "vending-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.common_tags
}

// Create the VNet
resource "azurerm_virtual_network" "vnet" {
  name                = "vending-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  tags                = var.common_tags
}

// Create a subnet with NSG association
resource "azurerm_subnet" "subnet" {
  name                 = "vending-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

}

// Associate the NSG to the subnet
resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}