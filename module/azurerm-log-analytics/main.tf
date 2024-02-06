terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.28.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_role_assignment" "logs" {
  count                = length(var.contributors)
  scope                = azurerm_resource_group.logs.id
  role_definition_name = "Log Analytics Contributor"
  principal_id         = var.contributors[count.index]
}

resource "azurerm_log_analytics_workspace" "logs" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  retention_in_days   = var.retention_in_days
  allow_resource_only_permissions = var.allow_resource_only_permissions
  local_authentication_disabled = var.local_authentication_disabled
  internet_ingestion_enabled = var.internet_ingestion_enabled
  internet_query_enabled = var.internet_query_enabled
  reservation_capacity_in_gb_per_day = var.reservation_capacity_in_gb_per_day
  tags                = var.tags
  identity {
    type          = var.identity.type
    identity_ids  = var.identity.identity_ids
  }
  data_collection_rule_id = var.data_collection_rule_id
  immediate_data_purge_on_30_days_enabled = var.immediate_data_purge_on_30_days_enabled
  daily_quota_gb      = var.daily_quota_gb
  cmk_for_query_forced = var.cmk_for_query_forced
}

resource "azurerm_security_center_workspace" "logs" {
  count        = length(var.security_center_subscription)
  scope        = "/subscriptions/${element(var.security_center_subscription, count.index)}"
  workspace_id = azurerm_log_analytics_workspace.logs.id
}

resource "azurerm_log_analytics_solution" "logs" {
  count                 = length(var.solutions)
  solution_name         = var.solutions[count.index].solution_name
  location              = var.resource_group_name
  resource_group_name   = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.logs.id
  workspace_name        = var.name

  plan {
    publisher = var.solutions[count.index].publisher
    product   = var.solutions[count.index].product
  }

  tags = var.tags
}
