variable "client_id" {
  type        = string
  description = "Service Principal Client ID for AKS"
}

variable "client_secret" {
  type        = string
  description = "Service Principal Client Secret for AKS"
}

variable "location" {
  type        = string
  description = "Location for the AKS cluster"
  default     = "East US 2"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group for AKS"
  default     = "devops-amir-dev-rg"
}
