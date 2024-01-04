provider "azurerm" {
  features {}
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  dns_prefix = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  network_profile {
    network_plugin = "azure"
  }
}

output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.example.id
}
