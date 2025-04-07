terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.50"
    }
  }
}

provider "azurerm" {
  alias           = "spoke"
  subscription_id = var.subscription_id
  features        {}
}