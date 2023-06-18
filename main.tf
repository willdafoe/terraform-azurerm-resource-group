### [BEGIN] main.tf ###
module "label" {
  source          = "github.com/D3V0PSPL38/terraform-context-label.git"
  enabled         = module.this.enabled
  name            = var.name
  namespace       = var.namespace
  environment     = var.environment
  stage           = var.stage
  location        = var.azure_location
  label_order     = var.label_order
  id_length_limit = var.id_length_limit
  tags            = var.tags
  context         = module.this.context
}

resource "azurerm_resource_group" "this" {
  count    = (local.e && var.az_resource_group) ? 1 : 0
  name     = format("%s-%02d", module.rg_label.id, count.index + 1)
  location = var.az_location
  tags     = module.label.tags
}
### [END] main.tf ###