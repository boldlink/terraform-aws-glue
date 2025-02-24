resource "aws_glue_crawler" "this" {
  for_each = var.crawlers

  name                   = each.value.name
  role                   = each.value.role
  database_name          = each.value.database_name
  description            = each.value.description
  schedule               = each.value.schedule
  classifiers            = each.value.classifiers
  configuration          = each.value.configuration
  security_configuration = each.value.security_configuration

  dynamic "recrawl_policy" {
    for_each = each.value.recrawl_policy != null ? [each.value.recrawl_policy] : []
    content {
      recrawl_behavior = recrawl_policy.value.recrawl_behavior
    }
  }

  # For s3_target, if any S3 targets are provided use them.
  # Otherwise, if no targets at all are provided then add a default S3 target.
  dynamic "s3_target" {
    for_each = length(each.value.targets.s3_targets) > 0 ? each.value.targets.s3_targets : (
      length(each.value.targets.jdbc_targets) == 0 &&
      length(each.value.targets.dynamo_db_targets) == 0 &&
      length(each.value.targets.catalog_targets) == 0 ? 
      [ { path = var.default_s3_target, exclusions = [] } ] : []
    )
    content {
      path       = s3_target.value.path
      exclusions = s3_target.value.exclusions
    }
  }

  dynamic "jdbc_target" {
    for_each = length(each.value.targets.jdbc_targets) > 0 ? each.value.targets.jdbc_targets : []
    content {
      connection_name = jdbc_target.value.connection_name
      path            = jdbc_target.value.path
      exclusions      = jdbc_target.value.exclusions
    }
  }

  dynamic "dynamodb_target" {
    for_each = length(each.value.targets.dynamo_db_targets) > 0 ? each.value.targets.dynamo_db_targets : []
    content {
      path = dynamodb_target.value.path
    }
  }

  dynamic "catalog_target" {
    for_each = length(each.value.targets.catalog_targets) > 0 ? each.value.targets.catalog_targets : []
    content {
      database_name = catalog_target.value.database_name
      # If table_name is not provided, return an empty list.
      tables        = catalog_target.value.table_name != null ? [catalog_target.value.table_name] : []
    }
  }

  tags = each.value.tags
}

# resource "aws_glue_data_catalog_encryption_settings" "main" {
#   count = var.enable_encryption ? 1 : 0

#   data_catalog_encryption_settings {
#     connection_password_encryption {
#       aws_kms_key_id = var.kms_key_arn
#       return_connection_password_encrypted = var.return_connection_password_encrypted
#     }

#     encryption_at_rest {
#       catalog_encryption_mode = var.glue_encryption_role_arn != "" ? "SSE-KMS-WITH-SERVICE-ROLE" : "SSE-KMS"
#       catalog_encryption_service_role = var.glue_encryption_role_arn != "" ? var.glue_encryption_role_arn : null
#       sse_aws_kms_key_id = var.kms_key_arn
#     }
#   }

#   depends_on = [ aws_glue_crawler.this ]
# }

# resource "aws_glue_resource_policy" "this" {
#   count = var.enable_glue_resource_policy && length(trim(var.glue_resource_policy, " ")) > 0 ? 1 : 0
#   policy_in_json = var.glue_resource_policy
# }
