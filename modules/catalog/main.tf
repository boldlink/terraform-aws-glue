resource "aws_glue_catalog_database" "this" {
  for_each = var.catalogs
  name     = each.value.name
  # If federated_database is provided, AWS Glue requires description to be null.
  description = each.value.federated_database != null ? null : each.value.description
  parameters  = each.value.parameters

  dynamic "federated_database" {
    for_each = each.value.federated_database != null ? [each.value.federated_database] : []
    content {
      connection_name = federated_database.value.connection_name
      identifier      = federated_database.value.identifier
    }
  }
  dynamic "target_database" {
    for_each = each.value.target_database != null ? [each.value.target_database] : []
    content {
      catalog_id    = target_database.value.catalog_id
      database_name = target_database.value.database_name
      region        = target_database.value.region
    }
  }
  dynamic "create_table_default_permission" {
    for_each = each.value.create_table_default_permission != null ? [each.value.create_table_default_permission] : []
    content {
      permissions = create_table_default_permission.value.permissions

      dynamic "principal" {
        for_each = create_table_default_permission.value.principal != null ? [create_table_default_permission.value.principal] : []
        content {
          data_lake_principal_identifier = principal.value.data_lake_principal_identifier
        }
      }
    }
  }
  tags = each.value.tags
}




