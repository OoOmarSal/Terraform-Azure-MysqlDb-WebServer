output "net_int" {
    value = azurerm_network_interface.net_int
  
}
output "security_groups_for_webserver" {
    value = azurerm_network_security_group.for_webserver
  
}

output "virtual_machine" {
    value = azurerm_linux_virtual_machine.laravelapp
  
}