variable "vms" {
  type = map(object({
    name                  = string
    location              = string
    resource_group_name   = string
    network_interface_ids = list(string)
    vm_size               = string
    admin_username        = string
    admin_password        = optional(string)
    admin_ssh_key = optional(object({
      username   = string
      public_key = string
    }))
    nic_name              = string
  }))
  description = "Map of Virtual Machines to create"
}
