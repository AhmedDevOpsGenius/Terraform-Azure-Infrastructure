module "network" {
  source             = "../module"
  name               = "devops-amir-stage"
  location           = "West US 2"
  resource_group_name = "devops-amir-stage-rg"
}

module "blob_storage" {
  source             = "../module/blob-storage"
  resource_group_name = "devops-amir-stage-rg"
  location           = "West US 2"
  name               = "devops-amir-stage"
}
