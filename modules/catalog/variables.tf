variable "catalogs" {
  description = "Map of Glue catalog database configurations. Only the catalog name is required; all other fields are optional."
  type = map(object({
    name        = string
    description = optional(string)
    parameters  = optional(map(string), {})
    federated_database = optional(object({
      connection_name = string
      identifier      = string
    }), null)
    target_database = optional(object({
      catalog_id    = string
      database_name = string
      region        = string
    }), null)
    create_table_default_permission = optional(object({
      permissions = list(string)
      principal = object({
        data_lake_principal_identifier = string
      })
    }), null)
    tags = optional(map(string), {})
  }))
  default = {}
}