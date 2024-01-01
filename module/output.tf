output "virtual_network_id" {
  value = azurerm_virtual_network.example.id
}

output "public_subnet_ids" {
  value = azurerm_subnet.public[*].id
}

output "private_subnet_ids" {
  value = azurerm_subnet.private[*].id
}

output "network_security_group_id" {
  value = azurerm_network_security_group.example.id
}
