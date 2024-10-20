# Create a Resource Group
resource "azurerm_resource_group" "main" {
  name     = "myResourceGroup"
  location = "East US"
}

# Create a Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "myVNet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

# Create a Subnet
resource "azurerm_subnet" "main" {
  name                 = "mySubnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a Public IP for the Load Balancer
resource "azurerm_public_ip" "main" {
  name                = "myPublicIP"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Create a Load Balancer
resource "azurerm_lb" "main" {
  name                = "myLoadBalancer"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "myFrontendConfig"
    public_ip_address_id = azurerm_public_ip.main.id
  }
}

# Create a Backend Address Pool
resource "azurerm_lb_backend_address_pool" "main" {
  name            = "myBackendPool"
  loadbalancer_id = azurerm_lb.main.id
}

# Create a Load Balancer Probe
resource "azurerm_lb_probe" "main" {
  name            = "httpProbe"
  loadbalancer_id = azurerm_lb.main.id
  protocol        = "Tcp"
  port            = 80
}

# Create a Load Balancer Rule
resource "azurerm_lb_rule" "main" {
  name                            = "httpRule"
  loadbalancer_id                 = azurerm_lb.main.id
  protocol                        = "Tcp"
  frontend_port                   = 80
  backend_port                    = 80
  frontend_ip_configuration_name  = azurerm_lb.main.frontend_ip_configuration[0].name
  backend_address_pool_ids        = [azurerm_lb_backend_address_pool.main.id]
  probe_id                        = azurerm_lb_probe.main.id
  enable_floating_ip              = false
  idle_timeout_in_minutes         = 4
}

# Create a Virtual Machine Scale Set
resource "azurerm_linux_virtual_machine_scale_set" "main" {
  name                = "myVMSS"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "Standard_DS1_v2"
  instances           = 1
  admin_username      = "azureuser"
  admin_password      = "P@ssw0rd1234!" 

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "myNIC"
    primary = true

    ip_configuration {
      name      = "myIPConfig"
      subnet_id = azurerm_subnet.main.id

      load_balancer_backend_address_pool_ids = [
        azurerm_lb_backend_address_pool.main.id
      ]
    }
  }

  
  disable_password_authentication = false

  upgrade_mode = "Manual"

  custom_data = base64encode(<<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF
  )
}

# Autoscale Settings
resource "azurerm_monitor_autoscale_setting" "main" {
  name                = "autoscaleSetting"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.main.id

  profile {
    name = "AutoScaleProfile"
    capacity {
      default = 1
      minimum = 1
      maximum = 5
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.main.id
        operator           = "GreaterThan"
        threshold          = 60
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = 1
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.main.id
        operator           = "LessThan"
        threshold          = 30
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = 1
        cooldown  = "PT5M"
      }
    }
  }
}
