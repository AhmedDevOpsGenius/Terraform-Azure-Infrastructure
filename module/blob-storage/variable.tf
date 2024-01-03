variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "storage_account_name" {
  type        = string
  description = "Name of the storage account"
}

variable "container_name" {
  type        = string
  description = "Name of the blob storage container"
}

variable "blob_name" {
  type        = string
  description = "Name of the blob"
}

variable "local_file_path" {
  type        = string
  description = "Local path of the file to upload to the blob"
}
