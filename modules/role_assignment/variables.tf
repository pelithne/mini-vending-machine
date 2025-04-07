variable object_id {
  description = "The object ID of the principal to assign the role to"
  type        = string
}

variable "scope" {
  description = "The scope for the role assignment"
  type        = string
}

variable "role_definition_name" {
  description = "The name of the role definition"
  type        = string
}

variable "subscription_id" {
  description = "The subscription ID to use for the role assignment"
  type        = string
}