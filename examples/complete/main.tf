/*
Ireland catalog  configurations

This example will test the global catalog encryption configurations.

Multiple Catalogs are created.
*/

module "catalog_ireland_1" {
  # checkov:skip=CKV_TF_1
  providers = {
    aws = aws.ireland
  }
  source      = "./../../modules/catalog_database"
  name        = "${var.name}-1-catalog"
  description = "${var.name}-1-catalog catalog database"
  parameters  = { Env = "example" }
  # federated_database = [
  #   {
  #     connection_name = "my-connection"
  #     identifier      = "federated-db-1"
  #   }
  # ]
  # target_database = [
  #   {
  #     catalog_id    = "123456789012"
  #     database_name = "target_db"
  #     region        = "us-west-2"
  #   }
  # ]
  # create_table_default_permission = [
  #   {
  #     permissions = ["ALL"]
  #     principal = [
  #       {
  #         data_lake_principal_identifier = "IAM_ROLE_OR_USER"
  #       }
  #     ]
  #   }
  # ]
  tags = { Environment = "example" }
}
module "catalog_ireland_2" {
  # checkov:skip=CKV_TF_1
  providers = {
    aws = aws.ireland
  }
  source      = "./../../modules/catalog_database"
  name        = "${var.name}-2-catalog"
  description = "${var.name}-2-catalog catalog database"
  parameters  = { Env = "example" }
  tags        = { Environment = "example" }
}


resource "aws_glue_catalog_table" "aws_glue_catalog_table" {
  provider      = aws.ireland
  name          = "${var.name}-table"
  database_name = "${var.name}-1-catalog"
  depends_on    = [module.catalog_ireland_1]
}

module "catalog_london_1" {
  # checkov:skip=CKV_TF_1
  providers = {
    aws = aws.london
  }
  source      = "./../../modules/catalog_database"
  name        = "${var.name}-1-london-catalog"
  description = "${var.name}-1-london catalog database"
  parameters  = { Env = "example" }
  tags        = { Environment = "example" }
}

module "catalog_london_2" {
  # checkov:skip=CKV_TF_1
  providers = {
    aws = aws.london
  }
  source      = "./../../modules/catalog_database"
  name        = "${var.name}-2-london-catalog"
  description = "${var.name}-2-london catalog database"
  parameters  = { Env = "example" }
  tags        = { Environment = "example" }
}

resource "aws_glue_classifier" "example" {
  provider = aws.ireland
  name     = "${var.name}-ireland"
  csv_classifier {
    allow_single_column    = false
    contains_header        = "PRESENT"
    delimiter              = ","
    disable_value_trimming = false
    header                 = ["example1", "example2"]
    quote_symbol           = "'"
  }
}

module "crawler" {
  # checkov:skip=CKV_TF_1
  providers = {
    aws = aws.ireland
  }
  source                   = "./../../modules/crawler"
  name                     = var.name
  role                     = module.role_ireland.arn
  database_name            = "${var.name}-1-catalog"
  s3_target_path           = "s3://${var.name}-complete-${local.account_id}-ireland/data/"
  s3_target_exclusions     = ["**/tmp/**"]
  description              = "Crawler to scan my S3 bucket"
  table_prefix             = "my_prefix_"
  update_behavior          = "UPDATE_IN_DATABASE"
  delete_behavior          = "LOG"
  schedule                 = "cron(0 12 * * ? *)"
  recrawl_policy           = "CRAWL_EVERYTHING"
  crawler_lineage_settings = "ENABLE"
  configuration = jsonencode({
    "Version" : 1.0,
    "CrawlerOutput" : {
      "Partitions" : { "AddOrUpdateBehavior" : "InheritFromTable" }
    }
  })
  classifiers = ["${var.name}-ireland"]
  tags        = { Environment = "example" }
  depends_on = [
    module.catalog_ireland_1,
    module.ireland_s3_bucket,
    module.role_ireland,
    time_sleep.wait_for_ireland
  ]
}

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
