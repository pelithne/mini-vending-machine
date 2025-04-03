variable "contributor_email" {
  type        = string
  description = "Email used as subscription contributor"
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

// Common tags for all resources
locals {
  common_tags = {
    environment = "vending"
    createdBy   = "terraform"
  }
}

// Call the subscription module
module "subscription" {
  source                = "./modules/subscription"
  contributor_email     = var.contributor_email
  billing_scope_id      = var.billing_scope_id
  subscription_name     = var.subscription_name
  subscription_alias_name = var.subscription_alias_name
  display_name          = var.display_name
  common_tags           = local.common_tags
}

// Call the networking module
module "networking" {
  source              = "./modules/networking"
  common_tags         = local.common_tags
  subscription_id     = module.subscription.subscription_id
  location            = "eastus"
  rg_name             = "vending-rg"
}