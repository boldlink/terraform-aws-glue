variable "crawlers" {
  description = "Map of Glue crawler configurations. Only name, role, and database_name are required."
  type = map(object({
    name                   = string
    role                   = string
    database_name          = string
    description            = optional(string, "")
    schedule               = optional(string, null)             # e.g., cron(15 12 * * ? *)
    classifiers            = optional(list(string), [])
    recrawl_policy         = optional(object({
      recrawl_behavior = string
    }), null)
    configuration          = optional(string, null)             # JSON configuration string
    security_configuration = optional(string, null)             # Name of a Glue security configuration (for encryption)
    targets = optional(object({
      s3_targets        = optional(list(object({
                           path       = string
                           exclusions = optional(list(string), [])
                         })), [])
      jdbc_targets      = optional(list(object({
                           connection_name = string
                           path            = string
                           exclusions      = optional(list(string), [])
                         })), [])
      dynamo_db_targets = optional(list(object({
                           path = string
                         })), [])
      catalog_targets   = optional(list(object({
                           database_name = string
                           table_name    = optional(string, null)
                         })), [])
    }), {
      s3_targets        = []
      jdbc_targets      = []
      dynamo_db_targets = []
      catalog_targets   = []
    })
    tags = optional(map(string), {})
  }))
  default = {}
}

variable "default_s3_target" {
  description = "Default S3 target path to use if no target is specified for a crawler."
  type        = string
  default     = "s3://my-default-bucket/"
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
