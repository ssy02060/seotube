

# resource "random_integer" "ri" {
#   min = 10000
#   max = 99999
# }

# resource "azurerm_cosmosdb_account" "db" {
#   name                = "${var.app_name}-cosmos-db-${random_integer.ri.result}"
#   location            = azurerm_resource_group.seotube.location
#   resource_group_name = azurerm_resource_group.seotube.name
#   offer_type          = "Standard"
#   kind                = "MongoDB"

#   enable_automatic_failover = true

#   capabilities {
#     name = "EnableAggregationPipeline"
#   }

#   capabilities {
#     name = "mongoEnableDocLevelTTL"
#   }

#   capabilities {
#     name = "MongoDBv3.4"
#   }

#   capabilities {
#     name = "EnableMongo"
#   }

#   consistency_policy {
#     consistency_level       = "BoundedStaleness"
#     max_interval_in_seconds = 300
#     max_staleness_prefix    = 100000
#   }

#   geo_location {
#     location          = var.location
#     failover_priority = 0
#   }

#   geo_location {
#     location          = "eastus"
#     failover_priority = 1
#   }
# }
