
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "mysql_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_mysql_flexible_server" "mysql_server" {
  name                = var.mysql_server_name
  resource_group_name = azurerm_resource_group.mysql_rg.name
  location            = azurerm_resource_group.mysql_rg.location

  administrator_login    = var.mysql_admin_username
  administrator_password = var.mysql_admin_password

  version                = var.mysql_version
  sku_name               = "B_Standard_B1ms"
  backup_retention_days  = 7
  geo_redundant_backup_enabled = false

  public_network_access = "Enabled"

  storage {
    size_gb = 32
  }

  tags = {
    environment = "learning"
    managed_by  = "terraform"
  }
}

resource "azurerm_mysql_flexible_server_firewall_rule" "client_ip" {
  name                = "allow-my-laptop"
  resource_group_name = azurerm_resource_group.mysql_rg.name
  server_name         = azurerm_mysql_flexible_server.mysql_server.name

  # Allow only your laptop's public IPv4 address.
  start_ip_address = var.client_ip
  end_ip_address   = var.client_ip
}
