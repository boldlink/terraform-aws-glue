resource "aws_glue_catalog_database" "this" {
  name = var.name

  # If federated_database is provided, AWS Glue requires description to be null.
  description = length(var.federated_database) > 0 ? null : var.description
  parameters  = var.parameters

  dynamic "federated_database" {
    for_each = var.federated_database
    content {
      connection_name = federated_database.value.connection_name
      identifier      = federated_database.value.identifier
    }
  }

  dynamic "target_database" {
    for_each = var.target_database
    content {
      catalog_id    = target_database.value.catalog_id
      database_name = target_database.value.database_name
      region        = target_database.value.region
    }
  }

  dynamic "create_table_default_permission" {
    for_each = var.create_table_default_permission
    content {
      permissions = create_table_default_permission.value.permissions

      dynamic "principal" {
        for_each = create_table_default_permission.value.principal
        content {
          data_lake_principal_identifier = principal.value.data_lake_principal_identifier
        }
      }
    }
  }

  tags = var.tags
}
