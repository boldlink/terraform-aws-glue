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