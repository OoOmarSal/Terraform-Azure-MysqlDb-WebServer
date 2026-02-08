output "virtual_machine_public_ip" {
    value = module.webserver.virtual_machine.public_ip_address

}

output "virtual_machine_user_name" {
    value = module.webserver.virtual_machine.admin_username

  
}

output "virtual_machine_password" {

    value = module.webserver.virtual_machine.admin_password
    sensitive = true


  
}

output "DB_USER" {
    value = module.db.DB_INFO.administrator_login
  
}

output "DB_PASSWORD" {
    value = module.db.DB_INFO.administrator_password
    sensitive = true
  
}
output "DB_HOST" {
    value = module.db.DB_INFO.name  
}