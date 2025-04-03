/*
  Root module calls:

  1) subscription module
  2) networking module
*/

/*
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
*/




// Call the networking module
module "networking" {
  source          = "./modules/networking"
  subscription_id = "e217cd2f-1a4f-44a8-b5ce-7ed01cb0dd4a"
  location        = "swedencentral"
  rg_name         = "vending-rg"
  common_tags     = local.common_tags
}