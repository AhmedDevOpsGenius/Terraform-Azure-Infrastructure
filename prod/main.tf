module "network" {
  source             = "../module"
  name               = "devops-amir-prod"
  location           = "West Europe"
  resource_group_name = "devops-amir-prod-rg"
}

module "blob_storage" {
  source             = "../module/blob-storage"
  resource_group_name = "devops-amir-prod-rg"
  location           = "West Europe"
  name               = "devops-amir-prod"
}
