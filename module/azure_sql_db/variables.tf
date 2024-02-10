variable "db_name" {
  description = "The name of the database to be created."
  default     = "azuresqldb"
}

variable "resource_group_name" {
  description = "Default resource group name that the database will be created in."
  default     = "amirrg"
}

variable "location" {
  description = "The location/region where the database and server are created."
  default     = "East US"
}

variable "db_edition" {
  description = "The edition of the database to be created."
  default     = "Basic"
}

variable "collation" {
  description = "The collation for the database."
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "server_version" {
  description = "The version for the database server."
  default     = "12.0"
}

variable "service_objective_name" {
  description = "The performance level for the database."
  default     = "Basic"
}

variable "sql_server_name" {
  description = "The administrator username of the SQL Server."
  default     = "myserver"
}

variable "sql_admin_username" {
  description = "The administrator username of the SQL Server."
  default     = "admin"
}

variable "sql_password" {
  description = "The administrator password of the SQL Server."
  default     = "Password123!"
}

variable "start_ip_address" {
  description = "Defines the start IP address used in your database firewall rule."
  default     = "0.0.0.0"
}

variable "end_ip_address" {
  description = "Defines the end IP address used in your database firewall rule."
  default     = "0.0.0.0"
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)
  default     = {
    tag1 = ""
    tag2 = ""
  }
}
