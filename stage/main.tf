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
module "aks_cluster" {
  source              = "../module/aks"
  client_id           = "your-service-principal-client-id"
  client_secret       = "your-service-principal-client-secret"
  location            = "West US 2"  # You can override this if needed
  resource_group_name = "devops-amir-stage-rg"
}
