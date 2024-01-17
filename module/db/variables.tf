variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Location for the PostgreSQL server"
}

variable "server_name" {
  type        = string
  description = "Name of the PostgreSQL server"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the PostgreSQL server"
}

variable "admin_password" {
  type        = string
  description = "Admin password for the PostgreSQL server"
}

variable "create_new_database" {
  type        = bool
  description = "Flag to indicate whether to create a new database"
}

variable "existing_database_snapshot_uri" {
  type        = string
  description = "URI of the snapshot for the existing database (if not creating a new one)"
}
