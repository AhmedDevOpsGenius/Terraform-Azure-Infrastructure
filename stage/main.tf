module "network" {
  source             = "../module"
  name               = "devops-amir-stage"
  location           = "West US 2"
  resource_group_name = "devops-amir-stage-rg"
}
