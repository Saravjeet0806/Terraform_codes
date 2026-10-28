# Azure MySQL Flexible Server with Terraform

This project provisions an **Azure Database for MySQL Flexible Server** using Terraform and enables secure, IP-restricted access from MySQL Workbench.

The infrastructure is deployed on Microsoft Azure, with public network access enabled and a firewall rule configured to allow connections only from the specified client IP address.

## Architecture

The following Azure resources are managed using Terraform:

- **Resource Group:** Organizes the Azure resources.
- **Azure Database for MySQL Flexible Server:** Hosts the MySQL database.
- **Firewall Rule:** Restricts incoming database connections to the configured client IP address.

## Tech Stack

- Microsoft Azure
- Azure Database for MySQL Flexible Server
- Terraform
- MySQL
- MySQL Workbench
- Azure CLI

## Project Structure

```text
.
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── .gitignore
└── README.md
```

| File | Description |
|---|---|
| `main.tf` | Defines the Azure provider, resource group, MySQL Flexible Server, and firewall rule. |
| `variables.tf` | Declares configurable inputs for the infrastructure. |
| `outputs.tf` | Exposes the server hostname and connection details. |
| `terraform.tfvars` | Contains environment-specific variable values. |
| `.gitignore` | Excludes sensitive files and Terraform-generated artifacts. |

## Prerequisites

Ensure the following tools are installed:

- [Terraform](https://developer.hashicorp.com/terraform/install)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- [MySQL Workbench](https://dev.mysql.com/downloads/workbench/)

An Azure subscription with permission to create MySQL Flexible Server resources is also required.

## Infrastructure Configuration

The Terraform configuration creates a MySQL Flexible Server with the following settings:

| Property | Configuration |
|---|---|
| Database Service | Azure Database for MySQL Flexible Server |
| Region | Central India or the configured Azure region |
| Compute Tier | Burstable |
| SKU | `B_Standard_B1ms` |
| MySQL Version | `8.0.21` |
| Storage | 32 GB |
| Backup Retention | 7 days |
| Network Access | Public |
| Database Port | `3306` |
| Firewall | Restricted to the configured client IPv4 address |

*Actual availability and pricing depend on the Azure subscription, region, and applicable offers.*

## Deployment

### 1. Authenticate with Azure

```powershell
az login
az account show
```

Select the intended subscription if necessary:

```powershell
az account set --subscription "<SUBSCRIPTION_ID>"
```

### 2. Configure Variables

Create a local `terraform.tfvars` file containing the required values:

```hcl
location             = "centralindia"
resource_group_name  = "mysql-workbench-rg"
mysql_server_name    = "your-unique-server-name"
mysql_admin_username = "mysqladmin"
mysql_admin_password = "YOUR_STRONG_PASSWORD"
client_ip            = "YOUR_PUBLIC_IPV4"
```

Use the region and server name corresponding to your actual deployment.

**Security:** Never commit passwords, subscription secrets, or other sensitive information to GitHub.

### 3. Retrieve Your Client IP

Run the following command in PowerShell:

```powershell
(Invoke-RestMethod -Uri "https://api.ipify.org").Trim()
```

Set the returned public IPv4 address as `client_ip`.

The firewall rule allows incoming connections from that address only.

### 4. Initialize and Validate Terraform

```powershell
terraform init
terraform fmt
terraform validate
```

### 5. Review and Apply

```powershell
terraform plan
terraform apply
```

Review the proposed changes before applying them.

If the infrastructure has already been deployed, these commands can also be used to review and manage subsequent configuration changes.

## Connecting Through MySQL Workbench

After the server has been provisioned successfully, connect to it from your local machine.

### Connection Settings

| Setting | Value |
|---|---|
| Connection Method | Standard TCP/IP |
| Hostname | MySQL server FQDN |
| Port | `3306` |
| Username | Configured administrator username |
| Password | Configured MySQL administrator password |
| SSL | Use the server's supported TLS configuration |

Retrieve the hostname using:

```powershell
terraform output -raw mysql_server_fqdn
```

### Connection Steps

1. Open MySQL Workbench.
2. Create a new database connection.
3. Select **Standard TCP/IP** as the connection method.
4. Enter the MySQL server FQDN and port `3306`.
5. Enter the administrator username.
6. Store the password securely.
7. Click **Test Connection**.
8. Connect to the server after the test succeeds.

Once connected, you can create databases, define tables, execute SQL queries, and manage database objects through MySQL Workbench.

## Security Considerations

- Public network access is enabled to support direct client connections.
- The firewall restricts access to the configured public IPv4 address.
- Database authentication is required in addition to firewall access.
- Use strong, unique credentials.
- Prefer encrypted connections and validate the server certificate.
- Update the firewall rule if your public IP changes.
- Never expose database credentials in source code or public repositories.
- Protect Terraform state files because they may contain sensitive values.

## Troubleshooting

### Connection Timeout

Verify that:

- The MySQL server is running.
- Public network access is enabled.
- The firewall rule contains your current public IPv4 address.
- Your network permits outbound connections to port `3306`.
- You are using the correct server FQDN.

### Authentication Failure

Verify the configured administrator username and password. Ensure that the credentials belong to the deployed server.

### Regional Provisioning Errors

If Azure reports `ProvisionNotSupportedForRegion`, check regional capacity, subscription restrictions, resource-provider registration, and SKU availability.

Refer to the [Azure MySQL capacity troubleshooting guide](https://learn.microsoft.com/en-us/azure/mysql/flexible-server/resolve-capacity-errors).

## Cleanup

To remove the Terraform-managed resources when they are no longer needed:

```powershell
terraform plan -destroy
terraform destroy
```

Review the destruction plan before confirming.

**Warning:** Destroying the MySQL server can permanently delete its databases and data. Back up anything important before cleanup.

## Learning Outcomes

This project demonstrates practical experience with:

- Infrastructure as Code using Terraform.
- Provisioning managed database services on Azure.
- Configuring Azure networking and database firewall rules.
- Managing infrastructure through the Azure CLI.
- Connecting to a cloud-hosted MySQL database using MySQL Workbench.
- Managing infrastructure lifecycle operations with Terraform.

## References

- [Azure Database for MySQL Flexible Server](https://learn.microsoft.com/en-us/azure/mysql/flexible-server/overview)
- [Azure MySQL Networking](https://learn.microsoft.com/en-us/azure/mysql/flexible-server/concepts-networking-public)
- [Terraform AzureRM Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [MySQL Workbench Documentation](https://dev.mysql.com/doc/workbench/en/)

---
**Author:** Saravjeet Singh