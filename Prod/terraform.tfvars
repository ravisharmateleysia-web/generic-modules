rg = {
  rg1 = {
    name     = "rv1"
    location = "eastus"
  }
}

vnet = {
  vnet1 = {
    name                = "vnet1"
    location            = "eastus"
    resource_group_name = "rv1"
    address_space       = ["10.0.0.0/16"]
  }
}

subnet = {
  appgw_subnet = {
    name                 = "appgw-subnet"
    resource_group_name  = "rv1"
    virtual_network_name = "vnet1"
    address_prefixes     = ["10.0.0.0/24"]
  }
  frontend_subnet = {
    name                 = "frontend-subnet"
    resource_group_name  = "rv1"
    virtual_network_name = "vnet1"
    address_prefixes     = ["10.0.1.0/24"]
  }
  backend_subnet = {
    name                 = "backend-subnet"
    resource_group_name  = "rv1"
    virtual_network_name = "vnet1"
    address_prefixes     = ["10.0.2.0/24"]
  }
  db_subnet = {
    name                 = "db-subnet"
    resource_group_name  = "rv1"
    virtual_network_name = "vnet1"
    address_prefixes     = ["10.0.3.0/24"]
  }
}

public_ip = {
  appgw_pip = {
    name                = "appgw-pip"
    resource_group_name = "rv1"
    location            = "eastus"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
}

nic = {
  frontend_nic = {
    subnet_name          = "frontend-subnet"
    nic_name             = "frontend-nic"
    location             = "eastus"
    resource_group_name  = "rv1"
    subnet_id            = ""
    virtual_network_name = "vnet1"
  }
  backend_nic = {
    subnet_name          = "backend-subnet"
    nic_name             = "backend-nic"
    location             = "eastus"
    resource_group_name  = "rv1"
    subnet_id            = ""
    virtual_network_name = "vnet1"
  }
}

vms = {
  frontend_vm = {
    name                  = "frontend-vm"
    location              = "eastus"
    resource_group_name   = "rv1"
    network_interface_ids = []
    vm_size               = "Standard_D2ads_v7"
    admin_username        = "azureadmin"
    admin_password        = "P@ssw0rd123456!"
    nic_name              = "frontend-nic"
  }
  backend_vm = {
    name                  = "backend-vm"
    location              = "eastus"
    resource_group_name   = "rv1"
    network_interface_ids = []
    vm_size               = "Standard_D2ads_v7"
    admin_username        = "azureadmin"
    admin_password        = "P@ssw0rd123456!"
    nic_name              = "backend-nic"
  }
}

nsgs = {
  appgw_nsg = {
    name                = "appgw-nsg"
    location            = "eastus"
    resource_group_name = "rv1"
    security_rules = [
      {
        name                       = "Allow_HTTP_Inbound"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "Internet"
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow_AppGw_HealthProbes"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "65200-65535"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
      }
    ]
  }
  backend_nsg = {
    name                = "backend-nsg"
    location            = "eastus"
    resource_group_name = "rv1"
    security_rules = [
      {
        name                       = "Allow_Frontend_To_Backend"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8080"
        source_address_prefix      = "10.0.1.0/24"
        destination_address_prefix = "10.0.2.0/24"
      }
    ]
  }
  db_nsg = {
    name                = "db-nsg"
    location            = "eastus"
    resource_group_name = "rv1"
    security_rules = [
      {
        name                       = "Allow_Backend_To_DB"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "5432"
        source_address_prefix      = "10.0.2.0/24"
        destination_address_prefix = "10.0.3.0/24"
      }
    ]
  }
}

databases = {
  prod_db = {
    name                   = "prod-pg-flex-db"
    resource_group_name    = "rv1"
    location               = "eastus"
    administrator_login    = "pgadmin"
    administrator_password = "P@ssw0rd123456!"
    sku_name               = "GP_Standard_D2s_v3"
    storage_mb             = 32768
    version                = "13"
  }
}
