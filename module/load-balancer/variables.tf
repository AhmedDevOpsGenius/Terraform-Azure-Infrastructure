variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Location for the resource group and load balancer"
}

variable "lb_name" {
  type        = string
  description = "Name of the Load Balancer"
}

variable "public_ip_id" {
  type        = string
  description = "ID of the Public IP associated with the Load Balancer"
}
