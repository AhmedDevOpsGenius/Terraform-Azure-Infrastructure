variable "name" {
  type        = string
  description = "Name for the AKS cluster"
}

variable "location" {
  type        = string
  description = "Location for the AKS cluster"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix for the AKS cluster"
}

variable "node_count" {
  type        = number
  description = "Number of nodes in the default node pool"
  default     = 3
}

variable "vm_size" {
  type        = string
  description = "Size of the VMs in the default node pool"
  default     = "Standard_DS2_v2"
}

variable "client_id" {
  type        = string
  description = "Service Principal Client ID"
}

variable "client_secret" {
  type        = string
  description = "Service Principal Client Secret"
}
