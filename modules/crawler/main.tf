resource "aws_glue_crawler" "this" {
  name          = var.name
  role          = var.role
  database_name = var.database_name
  description  = var.description != "" ? var.description : null
  schedule   = var.schedule != null ? var.schedule : null
  table_prefix = var.table_prefix != "" ? var.table_prefix : null
  s3_target {
    path       = var.s3_target_path
    exclusions = var.s3_target_exclusions
  }
  schema_change_policy {
    update_behavior = var.update_behavior
    delete_behavior = var.delete_behavior
  }
  dynamic "recrawl_policy" {
    for_each = var.recrawl_policy != "" ? [var.recrawl_policy] : []
    content {
      recrawl_behavior = recrawl_policy.value
    }
  }
  dynamic "lineage_configuration" {
    for_each = var.crawler_lineage_settings != "" ? [var.crawler_lineage_settings] : []
    content {
      crawler_lineage_settings = lineage_configuration.value
    }
  }
  configuration = var.configuration != "" ? var.configuration : null
  classifiers = var.classifiers
  tags = var.tags
}
