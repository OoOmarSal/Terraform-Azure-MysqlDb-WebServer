resource "azurerm_network_security_group" "for_webserver" {
  name                = "webserver_NSG"
  location            = var.my_res.location
  resource_group_name = var.my_res.name

  tags = {
    environment = "${var.env}-pubsg"
  }
}

resource "azurerm_network_security_rule" "allow_all_out_web" {
  name                        = "all_traffic_out"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.my_res.name
  network_security_group_name = azurerm_network_security_group.for_webserver.name
}

resource "azurerm_network_security_rule" "allow_tcp_in_web" {
  name                        = "allow_tcp_in"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.my_res.name
  network_security_group_name = azurerm_network_security_group.for_webserver.name
}
resource "azurerm_network_interface" "net_int" {
  name                = "for_webserver"
  location            = var.my_res.location
  resource_group_name = var.my_res.name


  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.public.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.IP_for_webserver.id
  }

}

resource "azurerm_linux_virtual_machine" "laravelapp" {
  name                = "laravelapp"
  resource_group_name = var.my_res.name
  location            = var.my_res.location
  size                = var.server_type
  admin_username = var.server_username
  admin_password = var.server_password
  network_interface_ids = [
    azurerm_network_interface.net_int.id,
  ]

  disable_password_authentication = false


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    environment = "${var.env}-server"
  }
}
