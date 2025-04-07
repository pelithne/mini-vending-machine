variable "subscription_id" {
  description = "The ID of the subscription in which to create the resource group."
  type        = string
  
} 
variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "spoke"
}
  
variable "location" {
  description = "The location of the resource group."
  type        = string
}
variable "environment" {
  description = "The environment for the resource group (e.g., dev, test, prod)."
  type        = string
  default     = "prod"
}