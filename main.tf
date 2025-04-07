terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.50"
      configuration_aliases = [
        azurerm.hub,
        azurerm.spoke
      ]
    }
  }
}

# Default azurerm provider configuration
provider "azurerm" {
  subscription_id = yamldecode(file("${path.module}/input.yaml")).spoke.subscription_id # Add this line
  features {}
}

provider "azurerm" {
  alias           = "spoke"
  subscription_id = yamldecode(file("${path.module}/input.yaml")).spoke.subscription_id
  features {}
}

provider "azurerm" {
  alias           = "hub"
  subscription_id = yamldecode(file("${path.module}/input.yaml")).hub.subscription_id
  features {}
}

# Apply tags at the subscription level for the spoke subscription
resource "azurerm_subscription" "spoke" {
  subscription_id   = yamldecode(file("${path.module}/input.yaml")).spoke.subscription_id
  subscription_name = yamldecode(file("${path.module}/input.yaml")).spoke.subscription_name
  tags              = yamldecode(file("${path.module}/input.yaml")).spoke.tags
}

module "spoke_resource_group" {
  source          = "./modules/resource_group"
  subscription_id = yamldecode(file("${path.module}/input.yaml")).spoke.subscription_id
  location        = yamldecode(file("${path.module}/input.yaml")).spoke.location
  environment     = yamldecode(file("${path.module}/input.yaml")).spoke.environment
  tags            = yamldecode(file("${path.module}/input.yaml")).spoke.tags

  providers = {
    azurerm = azurerm.spoke
  }
}

module "spoke_virtual_network" {
  source              = "./modules/virtual_network"
  subscription_id     = yamldecode(file("${path.module}/input.yaml")).spoke.subscription_id
  environment         = yamldecode(file("${path.module}/input.yaml")).spoke.environment
  location            = yamldecode(file("${path.module}/input.yaml")).spoke.location
  resource_group_name = module.spoke_resource_group.name
  address_space       = yamldecode(file("${path.module}/input.yaml")).spoke.address_space
  subnets             = yamldecode(file("${path.module}/input.yaml")).spoke.subnets
  route_tables        = yamldecode(file("${path.module}/input.yaml")).spoke.route_tables
  serial              = module.spoke_resource_group.serial

  providers = {
    azurerm = azurerm.spoke
  }
}

data "azurerm_virtual_network" "hub_vnet" {
  provider            = azurerm.hub
  name                = yamldecode(file("${path.module}/input.yaml")).hub.virtual_network_name
  resource_group_name = yamldecode(file("${path.module}/input.yaml")).hub.resource_group_name
}

module "virtual_network_peering" {
  source = "./modules/virtual_network_peering"

  spoke_resource_group_name  = module.spoke_resource_group.name
  spoke_virtual_network_name = module.spoke_virtual_network.vnet_name
  hub_resource_group_name    = yamldecode(file("${path.module}/input.yaml")).hub.resource_group_name
  hub_virtual_network_name   = yamldecode(file("${path.module}/input.yaml")).hub.virtual_network_name
  spoke_virtual_network_id   = module.spoke_virtual_network.vnet_id
  hub_virtual_network_id     = data.azurerm_virtual_network.hub_vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

  providers = {
    azurerm.spoke = azurerm.spoke
    azurerm.hub   = azurerm.hub
  }
}