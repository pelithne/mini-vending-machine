variable "contributor_email" {
  type        = string
  description = "Email for subscription contributor"
}

variable "billing_scope_id" {
  type        = string
  description = "Billing scope ID for new subscription"
}

variable "subscription_name" {
  type        = string
  description = "Name of the new subscription"
}

variable "subscription_alias_name" {
  type        = string
  description = "Subscription alias name"
}

variable "display_name" {
  type        = string
  description = "Human-readable subscription name in Azure Portal"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags to apply to resources"
}