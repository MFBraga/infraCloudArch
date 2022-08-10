output "IP_publico" {
    value = data.azurerm_public_ip.ds_public_ip.ip_address
    description = "WEB SERVER - Public IP Address"
}

output "resource_group_name" {
  value = azurerm_resource_group.main.name
  description = "Resource Group Name"
}

output "tls_private_key" {
  value     = tls_private_key.tls_key.private_key_pem
  sensitive = true
  description = "Private SSH/TLS Key"
}