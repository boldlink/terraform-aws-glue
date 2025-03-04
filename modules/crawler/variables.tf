variable "crawlers" {
  description = "Map of Glue crawler configurations. Only name, role, and database_name are required."
  type        = map(any)
  default     = {}
}

locals {
  crawler_defaults = {
    description            = ""
    schedule               = null
    classifiers            = []
    recrawl_policy         = null
    configuration          = null
    security_configuration = null
    schema_change_policy   = {
      delete_behavior = "LOG"
      update_behavior = "UPDATE_IN_DATABASE"
    }
    targets = {
      s3_targets        = []
      jdbc_targets      = []
      dynamo_db_targets = []
      catalog_targets   = []
    }
    tags = {}
  }

  crawlers_complete = {
    for key, crawler in var.crawlers : key => merge(local.crawler_defaults, crawler)
  }
}

variable "default_s3_target" {
  description = "Default S3 target path to use if no target is specified for a crawler."
  type        = string
  default     = ""
}
