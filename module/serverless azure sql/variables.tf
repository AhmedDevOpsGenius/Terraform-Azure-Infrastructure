variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "sql_server_name" {
  description = "The name of the SQL server"
  type        = string
}

variable "administrator_login" {
  description = "The administrator login name"
  type        = string
}

variable "administrator_password" {
  description = "The administrator password"
  type        = string
  sensitive   = true
}

variable "database_name" {
  description = "The name of the SQL database"
  type        = string
}

variable "elastic_pool_name" {
  description = "The name of the elastic pool"
  type        = string
}

variable "elastic_pool_max_size_gb" {
  description = "The max size of the elastic pool in GB"
  type        = number
  default     = 32
}

variable "elastic_pool_min_capacity" {
  description = "The minimum capacity of the elastic pool"
  type        = number
  default     = 0.5
}

variable "elastic_pool_max_capacity" {
  description = "The maximum capacity of the elastic pool"
  type        = number
  default     = 5
}

variable "restore_point_in_time" {
  description = "The point in time to restore the database to (RFC3339 format)"
  type        = string
  default     = ""
}
