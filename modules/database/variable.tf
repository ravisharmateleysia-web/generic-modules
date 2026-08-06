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
  description = "Map of PostgreSQL Flexible Server Databases to create"
  default     = {}
}
