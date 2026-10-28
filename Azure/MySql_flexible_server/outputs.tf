
output "resource_group_name" {
  description = "Azure resource group"
  value       = azurerm_resource_group.mysql_rg.name
}

output "mysql_server_name" {
  description = "MySQL Flexible Server name"
  value       = azurerm_mysql_flexible_server.mysql_server.name
}

output "mysql_server_fqdn" {
  description = "Hostname for MySQL Workbench"
  value       = azurerm_mysql_flexible_server.mysql_server.fqdn
}

output "mysql_admin_username" {
  description = "MySQL administrator username"
  value       = var.mysql_admin_username
}

output "mysql_port" {
  description = "MySQL connection port"
  value       = 3306
}

output "allowed_client_ip" {
  description = "Allowed laptop public IP"
  value       = var.client_ip
}
