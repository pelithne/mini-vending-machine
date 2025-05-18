variable "subnet_id" {
  description = "The ID of the subnet to associate with the NSG"
  type        = string
}

variable "nsg_name" {
  description = "The name of the Network Security Group"
  type        = string
}

variable "location" {
  description = "The location of the NSG"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the NSG"
  type        = map(string)
  default     = {}
}

variable "subscription_id" {
  type        = string
  description = "Subscription ID to apply the budget."
}