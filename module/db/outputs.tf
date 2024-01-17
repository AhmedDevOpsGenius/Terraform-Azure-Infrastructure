output "postgresql_server_id" {
  value = azurerm_postgresql_server.example.id
}

output "postgresql_database_id" {
  value = azurerm_postgresql_database.example[0].id
}
