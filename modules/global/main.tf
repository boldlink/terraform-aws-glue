

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
      kms_key_arn                   = each.value.encryption_configuration.cloudwatch_encryption.kms_key_arn
    }
    s3_encryption {
      s3_encryption_mode = each.value.encryption_configuration.s3_encryption.s3_encryption_mode
      kms_key_arn        = each.value.encryption_configuration.s3_encryption.kms_key_arn
    }
  }
}
