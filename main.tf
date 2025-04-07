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

provider "azurerm" {
  alias           = "spoke"
  subscription_id = "658cd127-a693-4622-85be-4c340afdc81a"
  features {}
}

provider "azurerm" {
  alias           = "hub"
  subscription_id = "6e2cc04e-7586-4343-86e1-e78513de21d6"
  features {}
}

module "spoke_resource_group" {
  source              = "./modules/resource_group"
  subscription_id     = "658cd127-a693-4622-85be-4c340afdc81a" # Spoke subscription
  resource_group_name = "spoke"
  location            = "swedencentral"
  environment         = "prod"

  providers = {
    azurerm = azurerm.spoke
  }
}

module "spoke_virtual_network" {
  source              = "./modules/virtual_network"
  subscription_id     = "658cd127-a693-4622-85be-4c340afdc81a" # Spoke subscription
  environment         = module.spoke_resource_group.environment
  location            = module.spoke_resource_group.location
  resource_group_name = module.spoke_resource_group.name
  serial              = module.spoke_resource_group.serial
  address_space       = ["10.2.0.0/16"]

  subnets = [
    {
      name            = "subnet-1"
      address_prefixes = ["10.2.1.0/24"]
    },
    {
      name            = "subnet-2"
      address_prefixes = ["10.2.2.0/24"]
    }
  ]

  route_tables = [
    {
      name  = "udr-1"
      route = {
        name                   = "default-route"
        address_prefix         = "0.0.0.0/0"
        next_hop_type          = "VirtualAppliance"
        next_hop_in_ip_address = "10.1.0.99"
      }
    },
    {
      name  = "udr-2"
      route = {
        name                   = "internal-route"
        address_prefix         = "10.3.0.0/16"
        next_hop_type          = "VirtualNetworkGateway"
        next_hop_in_ip_address = null
      }
    }
  ]

  providers = {
    azurerm = azurerm.spoke
  }
}

data "azurerm_virtual_network" "hub_vnet" {
  provider            = azurerm.hub
  name                = "hub_vnet"
  resource_group_name = "Default-ActivityLogAlerts"
}

module "virtual_network_peering" {
  source = "./modules/virtual_network_peering"

  spoke_resource_group_name  = module.spoke_resource_group.name
  spoke_virtual_network_name = module.spoke_virtual_network.vnet_name
  hub_resource_group_name    = data.azurerm_virtual_network.hub_vnet.resource_group_name
  hub_virtual_network_name   = data.azurerm_virtual_network.hub_vnet.name
  spoke_virtual_network_id   = module.spoke_virtual_network.vnet_id
  hub_virtual_network_id     = data.azurerm_virtual_network.hub_vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

  providers = {
    azurerm.spoke = azurerm.spoke
    azurerm.hub   = azurerm.hub
  }
}