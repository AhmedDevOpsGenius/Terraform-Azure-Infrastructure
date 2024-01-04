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
module "aks_cluster" {
  source              = "../module/aks"
  client_id           = "your-service-principal-client-id"
  client_secret       = "your-service-principal-client-secret"
  location            = "East US 2"  
  resource_group_name = "devops-amir-dev-rg"
}
