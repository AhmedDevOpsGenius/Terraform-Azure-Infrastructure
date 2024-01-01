# terraform-azure

This GitHub repository, terraform-azure, contains a modular Terraform module for provisioning Azure infrastructure. The module, located in the module directory, includes main.tf, variables.tf, provider.tf, and outputs.tf files. To deploy infrastructure in different environments:

Create environment-specific directories (dev, stage, prod).
In each environment, create a main.tf file referencing the module and customize environment-specific configurations if needed.

----

To initialize and apply the configuration for a specific environment, you can navigate to the respective environment directory and run the Terraform commands. For example:

# For dev environment
cd dev

terraform init

terraform apply

# For stage environment
cd ../stage

terraform init

terraform apply

# For prod environment
cd ../prod

terraform init

terraform apply
