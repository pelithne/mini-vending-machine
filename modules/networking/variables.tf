variable "location" {
  type        = string
  description = "Location for networking resources"
}

variable "rg_name" {
  type        = string
  description = "Name of the resource group for networking"
}

variable "subscription_id" {
  type        = string
  description = "Subscription ID where resources will be created"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags to apply to resources"
}