variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Location for the PostgreSQL server"
}

variable "server_name" {
  type        = string
  description = "Name of the PostgreSQL server"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the PostgreSQL server"
}

variable "admin_password" {
  type        = string
  description = "Admin password for the PostgreSQL server"
}

variable "create_new_database" {
  type        = bool
  description = "Flag to indicate whether to create a new database"
}

variable "existing_database_snapshot_uri" {
  type        = string
  description = "URI of the snapshot for the existing database (if not creating a new one)"
}

resource "azurerm_postgresql_server" "example" {
  name                = var.server_name
  location            = var.location
  resource_group_name = var.resource_group_name
  version             = "11"
  administrator_login = var.admin_username
  administrator_login_password = var.admin_password

  sku {
    name   = "B_Gen5_1"
    tier   = "Basic"
    capacity = 1
  }
}

resource "azurerm_postgresql_database" "example" {
  count                = var.create_new_database ? 1 : 0
  name                 = "example"
  resource_group_name  = azurerm_postgresql_server.example.resource_group_name
  server_name          = azurerm_postgresql_server.example.name
  charset              = "UTF8"
  collation            = "English_United States.1252"
}

resource "azurerm_postgresql_restore_point" "example" {
  count                = var.create_new_database ? 0 : 1
  name                 = "example-restore"
  resource_group_name  = azurerm_postgresql_server.example.resource_group_name
  server_name          = azurerm_postgresql_server.example.name
  restore_point_source_server_name = var.existing_database_snapshot_uri
}

output "postgresql_server_id" {
  value = azurerm_postgresql_server.example.id
}

output "postgresql_database_id" {
  value = azurerm_postgresql_database.example[0].id
}
