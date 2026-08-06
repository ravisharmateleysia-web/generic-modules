variable "rg" {
  type = map(object({
    name     = string
    location = string
  }))
  description = "Map of Resource Groups to create"
}
