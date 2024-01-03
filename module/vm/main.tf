variable "public_subnet_ids" {
  type    = list(string)
  default = []
}

variable "private_subnet_ids" {
  type    = list(string)
  default = []
}

resource "azurerm_network_interface" "public" {
  count               = length(var.public_subnet_ids)
  name                = "nic-public-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ip-config-public-${count.index + 1}"
    subnet_id                     = var.public_subnet_ids[count.index]
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "private" {
  count               = length(var.private_subnet_ids)
  name                = "nic-private-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ip-config-private-${count.index + 1}"
    subnet_id                     = var.private_subnet_ids[count.index]
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "public" {
  name                  = "vm-public"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = azurerm_network_interface.public[*].id

  # Add other VM configuration settings as needed
}

resource "azurerm_virtual_machine" "private" {
  name                  = "vm-private"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = azurerm_network_interface.private[*].id

  # Add other VM configuration settings as needed
}
