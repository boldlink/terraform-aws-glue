variable "crawlers" {
  description = "Map of Glue crawler configurations. Only name, role, and database_name are required."
  type = map(object({
    name                   = string
    role                   = string
    database_name          = string
    description            = optional(string)
    schedule               = optional(string) # e.g., cron(15 12 * * ? *)
    classifiers            = optional(list(string))
    recrawl_policy         = optional(object({ recrawl_behavior = string }))
    configuration          = optional(string) # JSON configuration string
    security_configuration = optional(string?)
    schema_change_policy = optional(object({
      delete_behavior = optional(string)                # Valid values: LOG, DELETE_FROM_DATABASE, or DEPRECATE_IN_DATABASE
      update_behavior = optional(string) # Valid values: LOG or UPDATE_IN_DATABASE
      }), {
      delete_behavior = "LOG"
      update_behavior = "UPDATE_IN_DATABASE"
    })
    targets = optional(object({
      s3_targets = optional(list(object({
        path       = string
        exclusions = optional(list(string), [])
      })), [])
      jdbc_targets = optional(list(object({
        connection_name = string
        path            = string
        exclusions      = optional(list(string), [])
      })), [])
      dynamo_db_targets = optional(list(object({
        path = string
      })), [])
      catalog_targets = optional(list(object({
        database_name = string
        table_name    = optional(string)
      })), [])
      }), {
      s3_targets        = []
      jdbc_targets      = []
      dynamo_db_targets = []
      catalog_targets   = []
    })
    tags = optional(map(string))
  }))
  default = {}
}

variable "default_s3_target" {
  description = "Default S3 target path to use if no target is specified for a crawler."
  type        = string
  default     = ""
}
