resource "azurerm_container_registry" "example" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"

  admin_enabled = false

  // Additional configuration for the ACR resource
}

resource "azurerm_container_registry_webhook" "example_webhook" {
  name                = "webhook-example"
  resource_group_name = azurerm_container_registry.example.resource_group_name
  registry_name       = azurerm_container_registry.example.name

  service_uri = azurerm_container_registry.example.login_server
  actions     = ["push"]  # Trigger the webhook on image push events

  // Additional configuration for the webhook
}

resource "azurerm_container_registry_repository" "example_repo" {
  name                = "example-repo"
  registry_name       = azurerm_container_registry.example.name
  resource_group_name = azurerm_container_registry.example.resource_group_name
}

output "acr_id" {
  value = azurerm_container_registry.example.id
}

output "acr_login_server" {
  value = azurerm_container_registry.example.login_server
}

output "repo_id" {
  value = azurerm_container_registry_repository.example_repo.id
}

output "repo_name" {
  value = azurerm_container_registry_repository.example_repo.name
}
