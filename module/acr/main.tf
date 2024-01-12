resource "azurerm_container_registry" "example" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"

  admin_enabled = false

  // Additional configuration for the ACR resource
}

output "acr_id" {
  value = azurerm_container_registry.example.id
}
