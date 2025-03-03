resource "aws_glue_crawler" "this" {
  for_each = var.crawlers

  schema_change_policy {
    delete_behavior = each.value.schema_change_policy.delete_behavior
    update_behavior = each.value.schema_change_policy.update_behavior
  }

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

  # S3 Target: Use provided s3_targets or default to var.default_s3_target if no other targets exist.
  dynamic "s3_target" {
    for_each = length(each.value.targets.s3_targets) > 0 ? each.value.targets.s3_targets : (
      length(each.value.targets.jdbc_targets) == 0 &&
      length(each.value.targets.dynamo_db_targets) == 0 &&
      length(each.value.targets.catalog_targets) == 0 ?
      [{ path = var.default_s3_target, exclusions = [] }] : []
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
      tables        = catalog_target.value.table_name != null ? [catalog_target.value.table_name] : []
    }
  }
  tags = each.value.tags
}
