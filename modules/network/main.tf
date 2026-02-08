resource "azurerm_virtual_network" "my_net" {
  name                = var.net_name
  resource_group_name = var.my_res.name
  location            = var.my_res.location
  address_space       = ["10.0.0.0/16"]

  tags = { environment = "${var.env}-net" }
}

resource "azurerm_subnet" "public" {
  name                 = "public_subnet"
  resource_group_name  = var.my_res.name
  virtual_network_name = azurerm_virtual_network.my_net.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "private" {
  name                 = "private_subnet"
  resource_group_name  = var.my_res.name
  virtual_network_name = azurerm_virtual_network.my_net.name
  address_prefixes     = ["10.0.1.0/24"]

  delegation {
    name = "mysql-flexible-server-delegation"

    service_delegation {
      name    = "Microsoft.DBforMySQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_public_ip" "my_nat_public_ip" {
  name                = "for_nat_gateway"
  resource_group_name = var.my_res.name
  location            = var.my_res.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = "${var.env}-public"
  }
}

resource "azurerm_nat_gateway" "my_nat" {
  name                = "nat-gateway"
  location            = var.my_res.location
  resource_group_name = var.my_res.name
  sku_name            = "Standard"

  tags = { environment = "${var.env}-nat-gateway" }
}

resource "azurerm_public_ip" "IP_for_webserver" {
  name                = "webserver_ip"
  resource_group_name = var.my_res.name
  location            = var.my_res.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = "${var.env}-publicIp"
  }
}
