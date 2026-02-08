variable "resource_group_name" {}

variable "location" {}

variable "env" {
  default = "dev"
}

variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}
variable "net_name" {}
variable "db_username" {}
variable "db_password" {}
variable "db_type" {}
variable "server_type" {}
variable "server_username" {}
variable "server_password" {}
variable "computer_name" {}