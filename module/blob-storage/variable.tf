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

variable "storage_account_name" {
  type        = string
  description = "Name of the storage account"
  default     = "uniqstoragenameamir"
}

variable "container_name" {
  type        = string
  description = "Name of the blob storage container"
  default     = "uniquecontainernameamir"
}

variable "blob_name" {
  type        = string
  description = "Name of the blob"
  default     = "blobamir"
}

variable "local_file_path" {
  type        = string
  description = "Local path of the file to upload to the blob"
  default     = "/home/centos/file.txt"
}
