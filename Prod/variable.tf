variable "rg" {
  type = map(object({
    name     = string
    location = string
  }))
  default = {}
}

variable "vnet" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
  }))
  default = {}
}

variable "subnet" {
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
  default = {}
}

variable "public_ip" {
  type = map(object({
    name              = string
    resource_group_name = string
    location          = string
    allocation_method = string
    sku               = string
  }))
  default = {}
}

variable "nic" {
  type = map(object({
    subnet_name          = string
    nic_name             = string
    location             = string
    resource_group_name  = string
    subnet_id            = string
    virtual_network_name = string
  }))
  default = {}
}

variable "vms" {
  type = map(object({
    name                  = string
    location              = string
    resource_group_name   = string
    network_interface_ids = list(string)
    vm_size               = string
    admin_username        = string
    admin_password        = optional(string)
    nic_name              = string
  }))
  default = {}
}

variable "nsgs" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    security_rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
  default = {}
}

variable "databases" {
  type = map(object({
    name                   = string
    resource_group_name    = string
    location               = string
    administrator_login    = string
    administrator_password = string
    sku_name               = string
    storage_mb             = number
    version                = string
  }))
  default = {}
}
