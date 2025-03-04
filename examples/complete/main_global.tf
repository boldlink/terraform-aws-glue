/*
London catalog  configurations

This example will test the global catalog encryption configurations.
In this example we are configuring encryption and resource policy for the catalog.

Multiple Catalogs are created.
*/

module "glue_global_settings_london" {
  # checkov:skip=CKV_TF_1
  source = "./../../modules/global"
  providers = {
    aws = aws.london
  }
  enable_encryption                    = true
  kms_key_arn                          = module.kms_london.arn
  return_connection_password_encrypted = true
  enable_glue_resource_policy          = true
  glue_resource_policy                 = data.aws_iam_policy_document.glue_resource_policy_london.json
  enable_glue_security_configuration   = true
  glue_security_configurations = [
    {
      name = "${var.name}-security_config-london"
      encryption_configuration = {
        cloudwatch_encryption = {
          cloudwatch_encryption_mode = "SSE-KMS"
          kms_key_arn                = module.kms_london.arn
        }
        job_bookmarks_encryption = {
          job_bookmarks_encryption_mode = "CSE-KMS"
          kms_key_arn                   = module.kms_london.arn
        }
        s3_encryption = {
          s3_encryption_mode = "SSE-KMS"
          kms_key_arn        = module.kms_london.arn
        }
      }
    }
  ]
  depends_on = [time_sleep.wait_for_london, module.role_london]
}


module "glue_global_settings_ireland" {
  # checkov:skip=CKV_TF_1
  source = "./../../modules/global"
  providers = {
    aws = aws.ireland
  }
  enable_encryption                    = true
  kms_key_arn                          = module.kms_ireland.arn
  glue_encryption_role_arn             = module.role_ireland.arn
  return_connection_password_encrypted = true
  depends_on                           = [time_sleep.wait_for_ireland, module.role_ireland]
}
