resource "azurerm_resource_group" "nyc_taxi_rg" {
  name     = "NYCTaxiResourceGroup"
  location = var.location
}

resource "microsoft_fabric_capacity" "nyc_taxi_capacity" {
  name           = "NYCTaxiFabricCapacity"
  resource_group = azurerm_resource_group.nyc_taxi_rg.name
  location       = var.location
  sku            = "F2"
  admin_email    = var.admin_email
}

resource "microsoft_fabric_workspace" "nyc_taxi_workspace" {
  name              = "NYCTaxiWorkspace"
  capacity_id       = microsoft_fabric_capacity.nyc_taxi_capacity.id
  authentication_type = "ServicePrincipal"
}

resource "microsoft_fabric_lakehouse" "nyc_taxi_lakehouse" {
  workspace_id = microsoft_fabric_workspace.nyc_taxi_workspace.id
  name         = "NYCTaxiLakehouse"
}

resource "microsoft_fabric_sql_database" "nyc_taxi_db" {
  workspace_id = microsoft_fabric_workspace.nyc_taxi_workspace.id
  name         = "NYCTaxiDB"
}

output "sql_connection_string" {
  value     = microsoft_fabric_sql_database.nyc_taxi_db.connection_string
  sensitive = true
}

output "workspace_id" {
  value = microsoft_fabric_workspace.nyc_taxi_workspace.id
}