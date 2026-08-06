resource "azurerm_postgresql_flexible_server" "db" {
  for_each               = var.databases
  name                   = each.value.name
  resource_group_name    = each.value.resource_group_name
  location               = each.value.location
  version                = each.value.version
  administrator_login    = each.value.administrator_login
  administrator_password = each.value.administrator_password
  storage_mb             = each.value.storage_mb
  sku_name               = each.value.sku_name

  tags = {
    environment = "production"
  }
}

resource "azurerm_postgresql_flexible_server_database" "db_instance" {
  for_each  = var.databases
  name      = "${each.value.name}-db"
  server_id = azurerm_postgresql_flexible_server.db[each.key].id
  collation = "en_US.utf8"
  charset   = "utf8"
}
