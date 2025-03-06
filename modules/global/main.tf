/*
Glue Data Catalog Encryption Settings
*/
resource "aws_glue_data_catalog_encryption_settings" "main" {
  count = var.enable_encryption ? 1 : 0

  data_catalog_encryption_settings {
    connection_password_encryption {
      aws_kms_key_id                       = var.kms_key_arn
      return_connection_password_encrypted = var.return_connection_password_encrypted
    }
    encryption_at_rest {
      catalog_encryption_mode         = var.glue_encryption_role_arn != "" ? "SSE-KMS-WITH-SERVICE-ROLE" : "SSE-KMS"
      catalog_encryption_service_role = var.glue_encryption_role_arn != "" ? var.glue_encryption_role_arn : null
      sse_aws_kms_key_id              = var.kms_key_arn
    }
  }
}

/*
Glue Resource Policy
*/
resource "aws_glue_resource_policy" "this" {
  count  = var.enable_glue_resource_policy && length(trim(var.glue_resource_policy, " ")) > 0 ? 1 : 0
  policy = var.glue_resource_policy
}

/*
Optional: Glue Security Configuration
*/
resource "aws_glue_security_configuration" "this" {
  for_each = var.enable_glue_security_configuration ? {
    for cfg in var.glue_security_configurations : cfg.name => cfg
  } : {}

  name = each.value.name

  encryption_configuration {
    cloudwatch_encryption {
      cloudwatch_encryption_mode = each.value.encryption_configuration.cloudwatch_encryption.cloudwatch_encryption_mode
      kms_key_arn                = each.value.encryption_configuration.cloudwatch_encryption.kms_key_arn
    }
    job_bookmarks_encryption {
      job_bookmarks_encryption_mode = each.value.encryption_configuration.job_bookmarks_encryption.job_bookmarks_encryption_mode
      kms_key_arn                   = each.value.encryption_configuration.job_bookmarks_encryption.kms_key_arn
    }
    s3_encryption {
      s3_encryption_mode = each.value.encryption_configuration.s3_encryption.s3_encryption_mode
      kms_key_arn        = each.value.encryption_configuration.s3_encryption.kms_key_arn
    }
  }
}

/*
Variables
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
        cloudwatch_encryption_mode = string
        kms_key_arn                = string
      })
      job_bookmarks_encryption = object({
        job_bookmarks_encryption_mode = string
        kms_key_arn                   = string
      })
      s3_encryption = object({
        s3_encryption_mode = string
        kms_key_arn        = string
      })
    })
  }))
  default = []
}
