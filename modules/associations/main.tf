resource "azurerm_nat_gateway_public_ip_association" "my_nat_gateway_public_ip_association" {
  nat_gateway_id       = var.my_nat.id
  public_ip_address_id = var.my_nat_public_ip.id
}

resource "azurerm_subnet_nat_gateway_association" "my_nat_gateway_association" {
  subnet_id      = var.private.id
  nat_gateway_id = var.my_nat.id
}



resource "azurerm_network_interface_security_group_association" "secG-with-networkInt" {
  network_interface_id      = var.net_int.id
  network_security_group_id = var.security_groups_for_webserver.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "linkWithVnet" {
  name                  = "VnetZone.com"
  private_dns_zone_name = var.for-db.name
  virtual_network_id    = var.my_net.id
  resource_group_name   = var.my_res.name
}

