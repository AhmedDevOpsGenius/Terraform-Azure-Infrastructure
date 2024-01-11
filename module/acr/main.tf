# module/acr/main.tf

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Name of the region for this infrastructure"
  default     = "East US 2"
}

variable "acr_name" {
  type        = string
  description = "Name of the Azure Container Registry"
}

resource "azurerm_container_registry" "example" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false

  network_rule {
    ip_range = "0.0.0.0/0"
  }
}
