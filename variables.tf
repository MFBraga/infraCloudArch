variable "prefix" {
    type        = string
    default     = "as04-aula02"
    description = "Common Prefix to be used in Resource Names"
}

variable "location" {
    type = string
    default = "eastus"
    description = "Resource Group Location"
}

variable "tag_env" {
    type        = string
    default     = "Classroom"
    description = "References Environment"
}

variable "tag_terraform" {
    type        = string
    default     = "Terraform"
    description = "References Resources created by Terraform"
}

variable "tag_application" {
    type        = string
    default     = "WEB Server"
    description = "References Application Category"
}

variable "username" {
    type        = string
    default     = "adminuser"
    description = "Administrator Username"
}

variable "vm_publisher" {
    type        = string
    default     = "OpenLogic"
#    default     = "Canonical"
    description = "Virtual Machine Source Image Publisher"
}

variable "vm_offer" {
    type        = string
    default     = "CentOS"
#    default     = "UbuntuServer"
    description = "Virtual Machine Source Image Offer"
}

variable "vm_sku" {
    type        = string
    default     = "8_5"
#    default     = "18.04-LTS"
    description = "Virtual Machine Source Image SKU"
}