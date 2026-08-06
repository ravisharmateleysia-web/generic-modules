variable "nic" {
  type = map(object({
    subnet_name          = string
    nic_name             = string
    location             = string
    resource_group_name  = string
    subnet_id            = string
    virtual_network_name = string
  }))
  description = "Map of Network Interfaces to create (private IP only)"
}