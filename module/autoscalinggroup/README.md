# Terraform Azure Infrastructure Setup


This project uses Terraform to set up an Azure infrastructure that includes a Virtual Network, Virtual Machine Scale Set with autoscaling policies, and a Load Balancer. The infrastructure is designed to automatically scale based on CPU usage, and a test application is deployed on the VMs.



## Resources Used


### Resource Group:

The container that holds related resources for the Azure solution.

Acts as a logical grouping for the resources used in this infrastructure.


### Virtual Network (VNet):

Provides an isolated network environment within Azure.

Enables the VMs and other resources to communicate securely.


### Subnet:

Subdivision within the VNet.

Used to group resources for better management and isolation.


### Public IP Address:

Assigned to the Load Balancer for external access.

Uses a static IP allocation to ensure consistency.


### Load Balancer:

Distributes incoming traffic across multiple VMs in the Scale Set.

Provides high availability for the application running on the VMs.


### Load Balancer Backend Address Pool:

Defines the set of VMs to which the Load Balancer routes traffic.


### Load Balancer Probe:

Monitors the health of the VMs.

Ensures traffic is routed only to healthy instances.


### Load Balancer Rule:

Configures how traffic is distributed to the backend VMs.

Includes settings for protocol, ports, and associated probes.


### Virtual Machine Scale Set:

Creates a group of identical VMs.

Automatically scales based on demand (e.g., CPU usage).


### Autoscale Settings:

Configures scaling policies for the VM Scale Set.

Increases the number of VMs when the CPU exceeds 60% and decreases it when below 30%.


## Usage


### Apply the Terraform Configuration:

Use **terraform init** to initialize the configuration.
Use **terraform apply** to create the infrastructure.


### Verify Deployment:

Check the Azure portal for the created resources.
Confirm the Load Balancer's public IP and access the deployed application.


## Destroy the Infrastructure:

Use **terraform destroy** to remove all created resources.


## Requirements


Terraform

Azure subscription

Azure CLI (for authentication)



**Summary**


This Terraform project demonstrates setting up an autoscaling infrastructure on Azure with a Load Balancer and scaling policies. The VMs are configured to automatically scale based on CPU usage, ensuring optimal resource utilization.
