module "network" {
  source             = "../module"
  name               = "devops-amir-dev"
  location           = "East US 2"
  resource_group_name = "devops-amir-dev-rg"
}

module "blob_storage" {
  source             = "../module/blob-storage"
  resource_group_name = "devops-amir-dev-rg"
  location           = "East US 2"
  name               = "devops-amir-dev"
}
