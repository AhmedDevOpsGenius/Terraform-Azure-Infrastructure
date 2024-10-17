 provider "azurerm" {
  features {}
}

# 1. Set up VNet
resource "azurerm_resource_group" "main" {
  name     = "myResourceGroup"
  location = "East US"
}

resource "azurerm_virtual_network" "main" {
  name                = "myVnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "main" {
  name                 = "mySubnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

# 2. Set up Autoscaling Group (VMSS)
resource "azurerm_linux_virtual_machine_scale_set" "main" {
  name                = "myVMSS"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Standard_DS1_v2"
  instances           = 2
  admin_username      = "adminuser"
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
      primary   = true
      subnet_id = azurerm_subnet.main.id
    }
  }

  # Deploy a test application
  custom_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y nginx
    echo "Hello, World from VMSS!" > /var/www/html/index.html
  EOF

  upgrade_mode = "Manual"
}

# Scaling Policies
resource "azurerm_monitor_autoscale_setting" "autoscale" {
  name                = "autoscaleSetting"
  resource_group_name = azurerm_resource_group.main.name
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.main.id
  enabled             = true

  profile {
    name = "defaultProfile"

    capacity {
      minimum = 2
      maximum = 5
      default = 2
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.main.id
        operator           = "GreaterThan"
        statistic          = "Average"
        threshold          = 60
        time_grain         = "PT1M"
        time_window        = "PT5M"
        time_aggregation   = "Average"
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }
  }
}

# 3. Set up Load Balancer
resource "azurerm_public_ip" "main" {
  name                = "myPublicIP"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
}

resource "azurerm_lb" "main" {
  name                = "myLoadBalancer"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "LoadBalancerFrontend"
    public_ip_address_id = azurerm_public_ip.main.id
  }
}

resource "azurerm_lb_backend_address_pool" "main" {
  name                = "myBackendPool"
  resource_group_name = azurerm_resource_group.main.name
  loadbalancer_id     = azurerm_lb.main.id
}

resource "azurerm_lb_probe" "main" {
  name                            = "myHealthProbe"
  resource_group_name             = azurerm_resource_group.main.name
  loadbalancer_id                 = azurerm_lb.main.id
  protocol                        = "Tcp"
  port                            = 80
  interval_in_seconds             = 5
  number_of_probes                 = 2
}

resource "azurerm_lb_rule" "main" {
  name                             = "httpRule"
  resource_group_name              = azurerm_resource_group.main.name
  loadbalancer_id                  = azurerm_lb.main.id
  protocol                         = "Tcp"
  frontend_port                    = 80
  backend_port                     = 80
  frontend_ip_configuration_name   = "LoadBalancerFrontend"
  backend_address_pool_id          = azurerm_lb_backend_address_pool.main.id
  probe_id                         = azurerm_lb_probe.main.id
}

# Associate the Scale Set with the Load Balancer
resource "azurerm_virtual_machine_scale_set_backend_address_pool_association" "main" {
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.main.id
  backend_address_pool_id      = azurerm_lb_backend_address_pool.main.id
}
