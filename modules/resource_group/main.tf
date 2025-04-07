resource "random_integer" "resource_group_serial" {
  min = 1
  max = 999
}

resource "azurerm_resource_group" "spoke_resource_group" {
  name     = "rg-alz-${var.environment}-${var.location}-${format("%03d", random_integer.resource_group_serial.result)}"
  location = var.location
}