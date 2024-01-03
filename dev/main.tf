module "network" {
  source             = "../module"
  name               = "devops-amir-dev"
  location           = "East US 2"
  resource_group_name = "devops-amir-dev-rg"
}

module "blob_storage" {
  source                = "../module/blob-storage"
  resource_group_name  = "devops-amir-dev-rg"
  storage_account_name  = "devopsamirdevstore"
  container_name        = "content"
  blob_name             = "my-awesome-content.zip"
  local_file_path       = "some-local-file.zip"
}

# Reference outputs from blob-storage module
output "storage_account_id" {
  value = module.blob_storage.storage_account_id
}
