terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }

   backend "azurerm" {
     resource_group_name  = "tfstate-rg"
     storage_account_name = "tfstateaccount7"
     container_name       = "tfstate"
     key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "my_res" {
  name     = var.resource_group_name
  location = var.location
}


module "network" {
  source = "./modules/network"
  net_name = var.net_name
  env = var.env
  my_res = azurerm_resource_group.my_res

  
}

module "webserver" {
  source = "./modules/webser_ni_sg"
  my_res = azurerm_resource_group.my_res
  env = var.env
  server_type = var.server_type
  server_username = var.server_username
  public_key_path = var.public_key_path
  public = module.network.public_subnet
  IP_for_webserver = module.network.public_ip_for_server
  server_password = var.server_password
  computer_name = var.computer_name
}

module "db" {
  source = "./modules/db_privtZone"
  my_res = azurerm_resource_group.my_res
  db_username = var.db_username
  db_password = var.db_password
  db_type = var.db_type
  private = module.network.private_subnet
  dns_zone_link = module.association.dns_zone_link
}


module "association" {
  source = "./modules/associations"
  my_nat = module.network.natgateway
  my_nat_public_ip = module.network.nat_publicip
  private = module.network.private_subnet
  for-db = module.db.private_dnszone
  my_net = module.network.my_net
  my_res = azurerm_resource_group.my_res
  net_int = module.webserver.net_int
  security_groups_for_webserver = module.webserver.security_groups_for_webserver
}