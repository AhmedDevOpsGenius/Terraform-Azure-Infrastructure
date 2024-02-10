resource "azurerm_sql_server" "server" {
  name                         = var.sql_server_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = var.server_version
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_password

  tags = var.tags
}

resource "azurerm_sql_database" "db" {
  name                   = var.db_name
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  server_name            = azurerm_sql_server.server.name
  edition                = var.db_edition
  collation              = var.collation
  requested_service_objective_name = var.service_objective_name

  tags = var.tags
}

resource "azurerm_sql_firewall_rule" "fw" {
  name                = "AllowAllWindowsAzureIps"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_sql_server.server.name
  start_ip_address    = var.start_ip_address
  end_ip_address      = var.end_ip_address
}
