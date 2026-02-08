output "private_subnet" {
  value = azurerm_subnet.private
  
}
output "public_subnet" {
    value = azurerm_subnet.public
  
}
output "nat_publicip" {
  value = azurerm_public_ip.my_nat_public_ip
}

output "natgateway" {
    value = azurerm_nat_gateway.my_nat
  
}
output "my_net" {
 value = azurerm_virtual_network.my_net 
}
output "public_ip_for_server" {
  value = azurerm_public_ip.IP_for_webserver
  
}