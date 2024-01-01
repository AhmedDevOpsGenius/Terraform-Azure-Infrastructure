module "network" {
  source             = "../module"
  name               = "devops-amir-prod"
  location           = "Central US"
  resource_group_name = "devops-amir-prod-rg"
}
