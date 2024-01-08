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
module "load_balancer" {
  source              = "../module/load-balancer"
  resource_group_name = "devops-amir-dev-rg" 
  location            = "East US 2"  
  lb_name             = "devops-amir-dev-lb" 
  public_ip_id        = module.public_ip.public_ip_id  # Update with the appropriate reference to the Public IP module
}
