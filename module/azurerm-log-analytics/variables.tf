variable "name" {
  description = "Specifies the name of the Log Analytics Workspace."
}

variable "resource_group_name" {
  description = "The name of the resource group in which the Log Analytics workspace is created."
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
}

variable "sku" {
  description = "Specifies the SKU of the Log Analytics Workspace."
}

variable "retention_in_days" {
  description = "The workspace data retention in days."
}

variable "allow_resource_only_permissions" {
  description = "Specifies if the log Analytics Workspace allow users accessing to data associated with resources they have permission to view, without permission to workspace."
  default     = true
}

variable "local_authentication_disabled" {
  description = "Specifies if the log Analytics workspace should enforce authentication using Azure AD."
  default     = false
}

variable "internet_ingestion_enabled" {
  description = "Should the Log Analytics Workspace support ingestion over the Public Internet?"
  default     = true
}

variable "internet_query_enabled" {
  description = "Should the Log Analytics Workspace support querying over the Public Internet?"
  default     = true
}

variable "reservation_capacity_in_gb_per_day" {
  description = "The capacity reservation level in GB for this workspace."
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

variable "identity" {
  description = "An identity block."
  type        = object({
    type          = string
    identity_ids  = list(string)
  })
}

variable "data_collection_rule_id" {
  description = "The ID of the Data Collection Rule to use for this workspace."
}

variable "immediate_data_purge_on_30_days_enabled" {
  description = "Whether to remove the data in the Log Analytics Workspace immediately after 30 days."
}

variable "daily_quota_gb" {
  description = "The workspace daily quota for ingestion in GB."
}

variable "cmk_for_query_forced" {
  description = "Is Customer Managed Storage mandatory for query management?"
}

variable "identity_ids" {
  description = "Specifies a list of user managed identity ids to be assigned."
}
