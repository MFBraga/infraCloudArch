## CREATE RESOURCE GROUP - AULA 02 (Infrastructure as Code)
resource "azurerm_resource_group" "main" {
    name     = "${var.prefix}_rg"
    location = "${var.location}"

    tags = {
        Environment = "${var.tag_env}"
        Created_by  = "${var.tag_terraform}"
    }
}

## CREATE VIRTUAL NETWORK (1044)
resource "azurerm_virtual_network" "vnet_1044" {
    name                = "${var.prefix}_vnet_1044"
    address_space       = ["10.44.0.0/16"]
    location            = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name
    
    tags = {
        Environment = "${var.tag_env}"
        Created_by  = "${var.tag_terraform}"
    }
}

## CREATE SUBNET FOR VMs (Virtual Machines)
resource "azurerm_subnet" "internal_1044_44" {
    name                 = "${var.prefix}_internal_1044_44"
    address_prefixes     = ["10.44.44.0/24"]
    resource_group_name  = azurerm_resource_group.main.name
    virtual_network_name = azurerm_virtual_network.vnet_1044.name
}

## GET STATIC PUBLIC IP ADDRESS
resource "azurerm_public_ip" "public_ip" {
    name                = "${var.prefix}_public_ip"
    location            = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name
    allocation_method   = "Static"

    tags = {
        Environment = "${var.tag_env}"
        Created_by  = "${var.tag_terraform}"
    }
}

## CREATE NETWORK INTERFACE CARD
resource "azurerm_network_interface" "internal_nic" {
    name                = "${var.prefix}_nic"
    location            = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name

    ip_configuration {
        name                            = "internal"
        subnet_id                       = azurerm_subnet.internal_1044_44.id
        private_ip_address_allocation   = "Dynamic"
        public_ip_address_id            = azurerm_public_ip.public_ip.id
    }

    tags = {
        Environment = "${var.tag_env}"
        Created_by  = "${var.tag_terraform}"
    }
}

## CREATE SECURITY GROUP AND RULES TO ACCESS VMs
resource "azurerm_network_security_group" "websrv_nsg" {
    name                = "${var.prefix}_websrv_nsg"
    location            = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name

    security_rule {
        name                       = "Allow_HTTP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "Allow_SSH"
        priority                   = 150
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        Environment = "${var.tag_env}"
        Created_by  = "${var.tag_terraform}"
    }
}

## ASSOCIATE/CONNECT NSG TO THE NIC
resource "azurerm_network_interface_security_group_association" "nsg_nic_assoc" {
    network_interface_id      = azurerm_network_interface.internal_nic.id
    network_security_group_id = azurerm_network_security_group.websrv_nsg.id
}

## CREATE SSH/TLS KEY
resource "tls_private_key" "tls_key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

## CREATE A LOCAL FILE WITH PRIVATE SSH/TLS KEY
resource "local_file" "private_key" {
    content         = tls_private_key.tls_key.private_key_pem
    filename        = "key.pem"
    file_permission = "0400"
}

## CREATE VIRTUAL MACHINE (WEB SERVER)
resource "azurerm_linux_virtual_machine" "vm_websrv" {
    name                  = "${var.prefix}_vm"
    location              = azurerm_resource_group.main.location
    resource_group_name   = azurerm_resource_group.main.name
    network_interface_ids = [ azurerm_network_interface.internal_nic.id ]
    size                  = "Standard_F2"

    computer_name                   = "${var.prefix}-srv"
    admin_username                  = var.username
    disable_password_authentication = true
    
    admin_ssh_key {
        username   = var.username
        public_key = tls_private_key.tls_key.public_key_openssh
    }

    os_disk {
        name                 = "${var.prefix}_disk"
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = var.vm_publisher
        offer     = var.vm_offer
        sku       = var.vm_sku
        version   = "latest"
    }

    depends_on = [ local_file.private_key ]

    tags = {
        Environment = var.tag_env
        Created_by  = var.tag_terraform
        Application = var.tag_application
    }
}

## CREATE DATA SOURCE TO ACCESS PUBLIC IP ADDRESS
data "azurerm_public_ip" "ds_public_ip" {
    name = azurerm_public_ip.public_ip.name
    resource_group_name = azurerm_resource_group.main.name
}

## EXECUTE REMOTE COMMANDS - INSTALL NGINX and FIREWALL CONFIGURATION
resource "null_resource" "install_nginx" {
    triggers = {
        order = azurerm_linux_virtual_machine.vm_websrv.id
    }

    connection {
        type = "ssh"
        host = data.azurerm_public_ip.ds_public_ip.ip_address
        user = var.username
        private_key = tls_private_key.tls_key.private_key_pem
    }

    provisioner "remote-exec" {
        inline = [
            "sudo sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*",       ## Change mirrors to vault.centos.org
            "sudo sed -i 's|baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*",

            "sudo dnf clean all",                                                       ## Remove all cache files/repository metadata
            "sudo dnf install -y nginx",                                                ## Install Nginx Packages
            
            "sudo systemctl stop firewalld",                                            ## Stop FirewallD Service
            "sudo systemctl disable firewalld",                                         ## Disable FirewallD Service

            "sudo systemctl enable nginx",                                              ## Enable Nginx Service to "start at boot"
            "sudo systemctl restart nginx",                                             ## Start Nginx Service
            
            "echo -e \"Nginx Service = $(sudo systemctl is-active nginx)\n\n\""         ## Nginx Service Status
        ]
    }

    depends_on = [ azurerm_linux_virtual_machine.vm_websrv ]
}