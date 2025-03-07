variable "name" {
  description = "The name of the Glue catalog database."
  type        = string
}

variable "description" {
  description = <<EOF
The catalog description. Note: If you supply a federated_database configuration, AWS Glue requires description to be null.
EOF
  type        = string
}

variable "parameters" {
  description = "A map of additional parameters for the catalog database."
  type        = map(string)
  default     = {}
}

variable "federated_database" {
  description = "A list of federated database objects. Each object must include connection_name and identifier."
  type = list(object({
    connection_name = string
    identifier      = string
  }))
  default = []
}

variable "target_database" {
  description = "A list of target database objects. Each object must include catalog_id, database_name, and region."
  type = list(object({
    catalog_id    = string
    database_name = string
    region        = string
  }))
  default = []
}

variable "create_table_default_permission" {
  description = "A list of objects defining default table creation permissions. Each object must include a list of permissions and a principal list."
  type = list(object({
    permissions = list(string)
    principal = list(object({
      data_lake_principal_identifier = string
    }))
  }))
  default = []
}

variable "tags" {
  description = "A map of tags to assign to the catalog database."
  type        = map(string)
  default     = {}
}
