variable "name" {
  type        = string
  description = "Name for this infrastructure"
}

variable "location" {
  type        = string
  description = "Name of the region for this infrastructure"
  default     = "East US 2"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}
