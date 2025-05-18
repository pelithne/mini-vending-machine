variable "budget_name" {
  type        = string
  description = "Name of the Azure budget."
}

variable "subscription_id" {
  type        = string
  description = "Subscription ID for the Azure budget."
}

variable "amount" {
  type        = number
  description = "Budget amount."
}

variable "notification_emails" {
  type = list(object({
    threshold = number
    operator  = string
    emails    = list(string)
  }))
  description = "List of notification thresholds and emails."
}