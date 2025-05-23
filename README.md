# Mini Subscription Vending Machine for Azure

## Introduction

This repository contains Terraform code for automating the creation of a new Azure subscription landing zone. The solution provisions a simple spoke network environment with subnets, network security groups (NSGs), route tables, tagging, budget controls, and role-based access control (RBAC) using Microsoft Entra security groups. It is designed to with provisioning an application landing zone quickly untill a complete vending machine is in place.

## What the Script Does

- **Creates and configures a spoke virtual network** with user-defined address spaces and subnets.
- **Deploys network security groups (NSGs)** and associates them with subnets.
- **Creates and associates route tables** to subnets for custom routing.
- **Applies consistent tagging** for cost management and organization.
- **Sets up Azure Budgets** with email notifications for cost control.
- **Creates Microsoft Entra security groups** and assigns Azure roles to them.
- **Supports hub-and-spoke network peering** with a central hub VNet.
- **All configuration is driven by a single `input.yaml` file** for easy customization.

## Features

- **Infrastructure as Code**: All resources are managed via Terraform for repeatability and version control.
- **Customizable Input**: Administrators can define all key parameters in `input.yaml` without editing Terraform code.
- **Security and Governance**: Built-in support for RBAC, tagging, and budget enforcement.
- **Extensible Naming Conventions**: Naming standards for resources and security groups.
- **Hub-Spoke Topology**: Supports peering with a central hub network.

## How to Operate the `input.yaml` File

Follow these steps to clone the repository and execute the Terraform scripts:

### 1. Clone the Repository

```sh
git clone https://github.com/pelithne/mini-vending-machine.git
cd mini-vending-machine
```

### 2. Configure The Input File.

 - Open input.yaml in your preferred editor.
 - Fill in all required fields as desceribed in the Input File Reference section below.
 - Save your changes.

### 3. Initialize Terraform
```sh
terraform init
```

### 4. Review The Planned Changes 

```sh
terraform plan -out plan.out
```

### 5. Apply Changes 

```sh
terraform apply "plan.out"
```

## Input File Reference (`input.yaml`)

Below is a table describing each parameter in the `input.yaml` file, along with detailed explanations and examples:

| **Section**              | **Parameter**                | **Description**                                                                                       | **Example**                       |
|--------------------------|------------------------------|-------------------------------------------------------------------------------------------------------|------------------------------------|
| `spoke`                  | `subscription_id`            | The Azure subscription ID where the spoke resources will be deployed.                                 | `12345678-1234-1234-1234-123456789abc` |
| `spoke`                  | `subscription_name`          | A friendly name for the subscription, used for documentation/reference.                               | `alz-application-spoke`           |
| `spoke`                  | `location`                   | Azure region for resource deployment. Use Azure region codes (e.g., `westeurope`, `swedencentral`).   | `swedencentral`                   |
| `spoke`                  | `environment`                | The environment type for the deployment (e.g., `dev`, `test`, `prod`).                               | `prod`                            |
| `spoke.tags`             | `Environment`                | Tag indicating the environment type.                                                                  | `Prod`                            |
| `spoke.tags`             | `Owner`                      | Tag indicating the resource owner or responsible team.                                                | `ITOps`                           |
| `spoke.tags`             | `CostCenter`                 | Tag for cost center or billing reference.                                                             | `CC12345`                         |
| `spoke.tags`             | `Project`                    | Tag for the project or workload name.                                                                 | `AzureLandingZone`                |
| `spoke.tags`             | `BusinessUnit`               | Tag for the business unit or department.                                                              | `Retail`                          |
| `spoke.tags`             | `Region`                     | Tag for the Azure region, for reference.                                                              | `swedencentral`                   |
| `spoke`                  | `address_space`              | Array of CIDR blocks for the spoke virtual network address space.                                     | `["10.2.0.0/16"]`                 |
| `spoke.subnet`           | `name`                       | Name of the subnet within the spoke VNet.                                                             | `subnet-1`                        |
| `spoke.subnet`           | `address_prefix`             | CIDR block for the subnet.                                                                            | `10.2.1.0/24`                     |
| `spoke.route_table.route`| `name`                       | Name of the route in the route table.                                                                 | `default-route`                   |
| `spoke.route_table.route`| `address_prefix`             | Address prefix for the route (e.g., `0.0.0.0/0` for all traffic).                                     | `0.0.0.0/0`                       |
| `spoke.route_table.route`| `next_hop_type`              | Next hop type for the route (e.g., `VirtualAppliance`, `Internet`, `VnetLocal`).                      | `VirtualAppliance`                |
| `spoke.route_table.route`| `next_hop_in_ip_address`     | IP address of the next hop (e.g., firewall or NVA).                                                   | `10.0.1.4`                        |
| `spoke.budget`           | `amount`                     | Monthly budget amount (in your Azure billing currency).                                               | `50`                              |
| `spoke.budget`           | `notification_emails`        | List of email addresses to notify when budget thresholds are reached.                                 | `["admin@example.com"]`           |
| `hub`                    | `subscription_id`            | Azure subscription ID for the hub environment.                                                        | `abcdef12-3456-7890-abcd-ef1234567890` |
| `hub`                    | `resource_group_name`        | Resource group name where the hub VNet is deployed.                                                   | `hub-rg`                          |
| `hub`                    | `virtual_network_name`       | Name of the hub virtual network.                                                                      | `hub_vnet`                        |
| `entra_security_group`   | `name`                       | Base name for the Microsoft Entra security group. Will be suffixed with `-` for customization.        | `alz-prod-`                       |
| `entra_security_group`   | `role_name`                  | Azure role to assign to the security group (e.g., `Contributor`, `Reader`, or a custom role).         | `Contributor`                     |

---
