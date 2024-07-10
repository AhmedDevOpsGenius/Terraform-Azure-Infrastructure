provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_sql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_password
}

resource "azurerm_sql_database" "sql_database" {
  name                = var.database_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  server_name         = azurerm_sql_server.sql_server.name
  edition             = "GeneralPurpose"
  requested_service_objective_name = "GP_S_Gen5_1"
  elastic_pool_name   = var.elastic_pool_name

  lifecycle {
    ignore_changes = [restore_point_in_time]
  }
  
  restore_point_in_time = var.restore_point_in_time != "" ? var.restore_point_in_time : null
}

resource "azurerm_sql_elastic_pool" "elastic_pool" {
  name                = var.elastic_pool_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  server_name         = azurerm_sql_server.sql_server.name
  edition             = "GeneralPurpose"
  max_size_gb         = var.elastic_pool_max_size_gb
  min_capacity        = var.elastic_pool_min_capacity
  max_capacity        = var.elastic_pool_max_capacity
}
