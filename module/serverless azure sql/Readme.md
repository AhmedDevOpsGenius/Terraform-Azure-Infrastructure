
# Azure SQL Serverless Terraform Module

## Overview

This Terraform module deploys a serverless Azure SQL Database within an Elastic Pool and provides an option to restore from an existing database backup.

## Prerequisites

- Terraform v0.13+ installed
- Azure account with necessary permissions

## Usage

```hcl
module "azure_sql_serverless" {
  source = "./path/to/module"

  resource_group_name          = "my-resource-group"
  location                     = "West Europe"
  sql_server_name              = "my-sql-server"
  administrator_login          = "adminuser"
  administrator_password       = "P@ssw0rd!"
  database_name                = "mydatabase"
  elastic_pool_name            = "my-elastic-pool"
  elastic_pool_max_size_gb     = 32
  elastic_pool_min_capacity    = 0.5
  elastic_pool_max_capacity    = 5
  restore_point_in_time        = "2021-06-01T13:10:00Z" # Leave empty if no restore needed
}
```

## Inputs

| Name                        | Description                                       | Type   | Default         | Required |
|-----------------------------|---------------------------------------------------|--------|-----------------|----------|
| `resource_group_name`       | The name of the resource group                    | string |                 | yes      |
| `location`                  | The location of the resource group                | string |                 | yes      |
| `sql_server_name`           | The name of the SQL server                        | string |                 | yes      |
| `administrator_login`       | The administrator login name                      | string |                 | yes      |
| `administrator_password`    | The administrator password                        | string |                 | yes      |
| `database_name`             | The name of the SQL database                      | string |                 | yes      |
| `elastic_pool_name`         | The name of the elastic pool                      | string |                 | yes      |
| `elastic_pool_max_size_gb`  | The max size of the elastic pool in GB            | number | 32              | no       |
| `elastic_pool_min_capacity` | The minimum capacity of the elastic pool          | number | 0.5             | no       |
| `elastic_pool_max_capacity` | The maximum capacity of the elastic pool          | number | 5               | no       |
| `restore_point_in_time`     | The point in time to restore the database to (RFC3339 format) | string | ""              | no       |

## Outputs

| Name                | Description                    |
|---------------------|--------------------------------|
| `sql_server_name`   | The name of the SQL server     |
| `sql_database_name` | The name of the SQL database   |

## Notes

- The `restore_point_in_time` variable should be in RFC3339 format (e.g., `2021-06-01T13:10:00Z`). Leave it empty if you do not need to restore from a backup.

- This module creates an Elastic Pool and assigns the database to it to take advantage of the serverless capabilities. Adjust the `elastic_pool_max_size_gb`, `elastic_pool_min_capacity`, and `elastic_pool_max_capacity` variables according to your requirements.
