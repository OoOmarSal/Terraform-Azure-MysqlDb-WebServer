output "private_dnszone" {
    value = azurerm_private_dns_zone.for-db
  
}

output "DB_INFO" {
    value = azurerm_mysql_flexible_server.database
  
}