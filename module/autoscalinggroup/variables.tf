# Location for the Azure resources
variable "location" {
  description = "The location where the resources will be created"
  default     = "East US"
}

# Resource Group Name
variable "resource_group_name" {
  description = "The name of the Resource Group"
  default     = "myResourceGroup"
}

# Virtual Network Name
variable "vnet_name" {
  description = "The name of the Virtual Network"
  default     = "myVNet"
}

# Subnet Name
variable "subnet_name" {
  description = "The name of the Subnet"
  default     = "mySubnet"
}

# VMSS Name
variable "vmss_name" {
  description = "The name of the Virtual Machine Scale Set"
  default     = "myVMSS"
}

# Admin Username
variable "admin_username" {
  description = "The admin username for the VM"
  default     = "adminuser"
}

# Admin Password
variable "admin_password" {
  description = "The admin password for the VM"
  default     = "Password1234!" # Avoid hardcoding in production
}

# Load Balancer Name
variable "lb_name" {
  description = "The name of the Load Balancer"
  default     = "myLoadBalancer"
}

# Public IP Name
variable "public_ip_name" {
  description = "The name of the Public IP for the Load Balancer"
  default     = "myPublicIP"
}

# Scaling Policies
variable "cpu_scale_up_threshold" {
  description = "CPU usage threshold for scaling up"
  default     = 60
}

variable "cpu_scale_down_threshold" {
  description = "CPU usage threshold for scaling down"
  default     = 30
}

variable "min_instance_count" {
  description = "Minimum number of instances"
  default     = 1
}

variable "max_instance_count" {
  description = "Maximum number of instances"
  default     = 5
}

variable "default_instance_count" {
  description = "Default number of instances"
  default     = 2
}
