/*
Global Data Catalog Encryption Settings
*/
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

/*
Glue Resource Policy
*/
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

resource "aws_glue_resource_policy" "this" {
  count  = var.enable_glue_resource_policy && length(trim(var.glue_resource_policy, " ")) > 0 ? 1 : 0
  policy = var.glue_resource_policy
}

/*
Optional: Glue Security Configuration
*/

variable "enable_glue_security_configuration" {
  description = "Flag to enable or disable Glue security configurations"
  type        = bool
  default     = false
}

variable "glue_security_configurations" {
  description = "List of Glue security configurations"
  type = list(object({
    name = string
    encryption_configuration = object({
      cloudwatch_encryption = object({
        cloudwatch_encryption_mode = optional(string?, "DISABLED")
        kms_key_arn        = optional(string?, null)
      })
      job_bookmarks_encryption = object({
        job_bookmarks_encryption_mode = optional(string?, "DISABLED")
        kms_key_arn        = optional(string?, null)
      })
      s3_encryption = object({
        s3_encryption_mode = optional(string?, "DISABLED")
        kms_key_arn        = optional(string?, null)
      })
    })
  }))
  default = []
}