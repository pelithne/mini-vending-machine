variable "spoke_resource_group_name" {
  description = "The name of the resource group for the spoke virtual network."
  type        = string
}

variable "spoke_virtual_network_name" {
  description = "The name of the spoke virtual network."
  type        = string
}

variable "hub_resource_group_name" {
  description = "The name of the resource group for the hub virtual network."
  type        = string
}

variable "hub_virtual_network_name" {
  description = "The name of the hub virtual network."
  type        = string
}

variable "spoke_virtual_network_id" {
  description = "The ID of the spoke virtual network."
  type        = string
}

variable "hub_virtual_network_id" {
  description = "The ID of the hub virtual network."
  type        = string
}

variable "allow_virtual_network_access" {
  description = "Whether to allow virtual network access."
  type        = bool
  default     = true
}

variable "allow_forwarded_traffic" {
  description = "Whether to allow forwarded traffic."
  type        = bool
  default     = true
}