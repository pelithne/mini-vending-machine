variable "contributor_email" {
  type        = string
  description = "Email used as subscription contributor"
  default     = "pelithne@microsoft.com"
}

variable "billing_scope_id" {
  type        = string
  description = "Billing scope ID"
  default     = "/providers/Microsoft.Billing/billingAccounts/00000000/enrollmentAccounts/00000000"
}

variable "subscription_name" {
  type        = string
  description = "Subscription name"
  default     = "MyVendingSubscription"
}

variable "subscription_alias_name" {
  type        = string
  description = "Subscription alias name"
  default     = "my-vending-subscription"
}

variable "display_name" {
  type        = string
  description = "Subscription display name"
  default     = "My Vending Subscription"
}

locals {
  common_tags = {
    environment = "vending"
    createdBy   = "terraform"
  }
}