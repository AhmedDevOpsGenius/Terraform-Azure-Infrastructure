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
module "aks_cluster" {
  source              = "../module/aks"
  client_id           = "your-service-principal-client-id"
  client_secret       = "your-service-principal-client-secret"
  location            = "North Europe" 
  resource_group_name = "devops-amir-prod-rg"
}
