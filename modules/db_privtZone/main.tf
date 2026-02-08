
resource "azurerm_private_dns_zone" "for-db" {
  name                = "db.mysql.database.azure.com"
  resource_group_name = var.my_res.name
}


resource "azurerm_mysql_flexible_server" "database" {
  name                   = "slhf-db"
  resource_group_name    = var.my_res.name
  location               = var.my_res.location
  administrator_login    = var.db_username
  administrator_password = var.db_password
  backup_retention_days  = 7
  delegated_subnet_id    = var.private.id
  private_dns_zone_id    = azurerm_private_dns_zone.for-db.id
  sku_name               = var.db_type
  depends_on = [var.dns_zone_link]
}
