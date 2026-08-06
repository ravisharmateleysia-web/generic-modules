data "azurerm_network_interface" "example" {
  for_each            = var.vms
  name                = each.value.nic_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_linux_virtual_machine" "main" {
  for_each                        = var.vms
  name                            = each.value.name
  location                        = each.value.location
  resource_group_name             = each.value.resource_group_name
  size                            = each.value.vm_size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = true

  network_interface_ids = [data.azurerm_network_interface.example[each.key].id]

  os_disk {
    name                 = "${each.value.name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  admin_ssh_key {
    username   = each.value.admin_ssh_key.username
    public_key = each.value.admin_ssh_key.public_key
  }

  tags = {
    environment = "staging"
  }
}