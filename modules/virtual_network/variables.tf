variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "location" {
  description = "The location of the virtual network"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "subnet" {
  description = "The configuration for the subnet"
  type = object({
    name           = string
    address_prefix = string
  })
}

variable "route" {
  description = "The configuration for the route"
  type = object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = string
  })
}

variable "prefix" {
  description = "The prefix for naming resources (e.g., resource group, NSG, UDR)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the virtual network"
  type        = map(string)
  default     = {}
}
variable "subscription_id" {
  description = "The ID of the subscription in which to create the virtual network."
  type        = string
  
}