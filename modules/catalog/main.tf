resource "aws_glue_catalog_database" "this" {
  for_each = var.catalogs

  name        = each.value.name
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

resource "aws_glue_data_catalog_encryption_settings" "main" {
  count = var.enable_encryption ? 1 : 0

  data_catalog_encryption_settings {
    connection_password_encryption {
      aws_kms_key_id                       = var.kms_key_arn
      return_connection_password_encrypted = var.return_connection_password_encrypted
    }

    encryption_at_rest {
      catalog_encryption_mode         = var.glue_encryption_role_arn != "" ? "SSE-KMS-WITH-SERVICE-ROLE" : "SSE-KMS"
      catalog_encryption_service_role = var.glue_encryption_role_arn != "" ? var.glue_encryption_role_arn : null
      sse_aws_kms_key_id              = var.kms_key_arn
    }
  }

  depends_on = [ aws_glue_catalog_database.this ]
}

resource "aws_glue_resource_policy" "this" {
  count         = var.enable_glue_resource_policy && length(trim(var.glue_resource_policy, " ")) > 0 ? 1 : 0
  policy = var.glue_resource_policy
}



output "catalog_database_names" {
  description = "The names of the Glue catalog databases created."
  value       = { for k, db in aws_glue_catalog_database.this : k => db.name }
}

output "glue_resource_policy_status" {
  description = "ID of the Glue resource policy, if applied."
  value       = aws_glue_resource_policy.this[*].id
}


variable "catalogs" {
  description = "Map of Glue catalog database configurations. Only the catalog name is required; all other fields are optional."
  type = map(object({
    name                           = string
    description                    = optional(string, "")
    parameters                     = optional(map(string), {})
    federated_database             = optional(object({
      connection_name = string
      identifier      = string
    }), null)
    target_database                = optional(object({
      catalog_id    = string
      database_name = string
      region        = string
    }), null)
    create_table_default_permission = optional(object({
      permissions = list(string)
      principal   = object({
        data_lake_principal_identifier = string
      })
    }), null)
    tags                           = optional(map(string), {})
  }))
  default = {}
}

variable "enable_encryption" {
  description = "Globally enable Glue Data Catalog encryption settings"
  type        = bool
  default     = false
}

variable "kms_key_arn" {
  description = "The ARN of the KMS key to use for Glue encryption"
  type        = string
  default     = ""
}

variable "glue_encryption_role_arn" {
  description = "The ARN of the IAM role for Glue catalog encryption service role (optional). Leave empty if not used."
  type        = string
  default     = ""
}

variable "return_connection_password_encrypted" {
  description = "Override for returning connection passwords encrypted (defaults to true)"
  type        = bool
  default     = true
}

variable "enable_glue_resource_policy" {
  description = "Globally enable applying a Glue resource policy"
  type        = bool
  default     = false
}

variable "glue_resource_policy" {
  description = "A JSON string defining the Glue resource policy"
  type        = string
  default     = ""
}

