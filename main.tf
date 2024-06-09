resource "azurerm_resource_group" "resourcegroups" {
    name        = var.ResourceGroup
    location    = var.Location
}

resource "azurerm_storage_account" "infra" {
  name                     = lower("${var.ResourceGroup}infra")
  resource_group_name      = azurerm_resource_group.resourcegroups.name
  location                 = azurerm_resource_group.resourcegroups.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.infra.name
  container_access_type = "private"
}
