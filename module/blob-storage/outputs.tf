output "storage_account_id" {
  value = azurerm_storage_account.example.id
}

output "container_id" {
  value = azurerm_storage_container.example.id
}

output "blob_id" {
  value = azurerm_storage_blob.example.id
}
