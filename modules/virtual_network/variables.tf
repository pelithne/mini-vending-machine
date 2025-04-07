variable "environment" {
  description = "The environment for the virtual network (e.g., dev, test, prod)."
  type        = string
}

variable "location" {
  description = "The Azure region where the virtual network will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the virtual network will be created."
  type        = string
}

variable "serial" {
  description = "The serial number for the virtual network."
  type        = number
}

variable "address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
}

variable "subnets" {
  description = "List of subnets to create."
  type = list(object({
    name            = string
    address_prefixes = list(string)
  }))
}

variable "route_tables" {
  description = "List of route tables to create."
  type = list(object({
    name  = string
    route = object({
      name                   = string
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = string
    })
  }))
}

variable "subscription_id" {
  description = "The subscription ID where the virtual network will be created."
  type        = string
  
}