
variable "location" {
  description = "Azure region"
  type        = string
  default     = "southindia"
}

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "mysql-workbench-rg"
}

variable "mysql_server_name" {
  description = "Globally unique, lowercase MySQL server name"
  type        = string

  validation {
    condition = (
      length(var.mysql_server_name) >= 3 &&
      length(var.mysql_server_name) <= 63 &&
      can(regex("^[a-z0-9][a-z0-9-]*[a-z0-9]$", var.mysql_server_name))
    )
    error_message = "Use 3-63 lowercase letters, numbers, or hyphens. The name must start and end with a letter or number."
  }
}

variable "mysql_admin_username" {
  description = "MySQL administrator username"
  type        = string
  default     = "mysqladmin"
}

variable "mysql_admin_password" {
  description = "MySQL administrator password"
  type        = string
  sensitive   = true
}

variable "mysql_version" {
  description = "MySQL engine version"
  type        = string
  default     = "8.0.21"
}

variable "client_ip" {
  description = "Your laptop's public IPv4 address"
  type        = string

  validation {
    condition     = can(cidrhost("${var.client_ip}/32", 0))
    error_message = "Enter a valid IPv4 address without a CIDR suffix."
  }
}
