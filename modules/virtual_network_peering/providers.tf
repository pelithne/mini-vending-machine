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