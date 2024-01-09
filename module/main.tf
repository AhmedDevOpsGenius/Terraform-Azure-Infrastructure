resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "example" {
  name                = var.name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "public" {
  count               = 3
  name                = "public-subnet-${count.index + 1}"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes    = ["10.0.${count.index + 1}.0/24"]
}

resource "azurerm_subnet" "private" {
  count               = 3
  name                = "private-subnet-${count.index + 1}"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes    = ["10.0.${count.index + 4}.0/24"]
}

resource "azurerm_network_security_group" "example" {
  name                = "${var.name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "allow_http" {
  name                        = "allow_http"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example.name
  network_security_group_name = azurerm_network_security_group.example.name
}

resource "azurerm_network_security_rule" "allow_https" {
  name                        = "allow_https"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example.name
  network_security_group_name = azurerm_network_security_group.example.name
}

# Deny all inbound traffic to private subnets from the internet
resource "azurerm_network_security_rule" "deny_internet_to_private" {
  count                       = length(azurerm_subnet.private)
  name                        = "deny_internet_to_private_${count.index}"
  priority                    = 120 + count.index
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "Internet"
  destination_address_prefix  = azurerm_subnet.private[count.index].address_prefixes[0]

  resource_group_name         = azurerm_resource_group.example.name
  network_security_group_name = azurerm_network_security_group.example.name
}

# Allow outbound traffic from each private subnet to the internet
resource "azurerm_network_security_rule" "allow_private_to_internet" {
  count                       = length(azurerm_subnet.private)
  name                        = "allow_private_to_internet_${count.index}"
  priority                    = 130 + count.index
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = azurerm_subnet.private[count.index].address_prefixes[0]
  destination_address_prefix  = "13.107.6.152/31"  # Replace this with the appropriate IP range

  resource_group_name         = azurerm_resource_group.example.name
  network_security_group_name = azurerm_network_security_group.example.name
}
