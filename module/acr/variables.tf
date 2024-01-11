variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Name of the region for this infrastructure"
  default     = "East US 2"
}

variable "acr_name" {
  type        = string
  description = "Name of the Azure Container Registry"
}
