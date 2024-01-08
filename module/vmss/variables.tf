variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Location for the resource group and VMSS"
}

variable "name" {
  type        = string
  description = "Name for this infrastructure"
}

variable "vmss_name" {
  type        = string
  description = "Name of the VMSS"
}

variable "vmss_instance_count" {
  type        = number
  description = "Number of instances in the VMSS"
}
