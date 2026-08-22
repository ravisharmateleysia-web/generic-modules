module "rg" {
  source = "../modules/rg"
  rg     = var.rg
}

module "vnet" {
  source = "../modules/vnet"
  vnet   = var.vnet
}

module "subnet" {
  source     = "../modules/subnet"
  depends_on = [module.vnet]
  subnet     = var.subnet
}

module "nsg" {
  source = "../modules/nsg"
  nsgs   = var.nsgs
}

module "public_ip" {
  source    = "../modules/public_ip"
  public_ip = var.public_ip
}

module "VM" {
  source     = "../modules/VM"
  depends_on = [module.rg, module.vnet, module.subnet]
  nic        = var.nic
}

module "VM2" {
  source     = "../modules/VM2"
  depends_on = [module.rg, module.vnet, module.subnet, module.VM]
  vms        = var.vms
}

module "app_gateway" {
  source     = "../modules/app_gateway"
  depends_on = [module.rg, module.vnet, module.subnet, module.public_ip, module.VM2]

  app_gateways = {
    appgw1 = {
      name                 = "prod-app-gateway"
      resource_group_name  = "rv1"
      location             = "eastus"
      sku_name             = "Standard_v2"
      sku_tier             = "Standard_v2"
      sku_capacity         = 1
      subnet_id            = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rv1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/appgw-subnet"
      public_ip_address_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rv1/providers/Microsoft.Network/publicIPAddresses/appgw-pip"
      backend_ip_addresses = ["10.0.1.4"]
    }
  }
}

module "database" {
  source     = "../modules/database"
  depends_on = [module.rg, module.subnet]
  databases  = var.databases
}
