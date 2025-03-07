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
  name        ="${var.name}-1-catalog"
  description = "${var.name}-1-catalog catalog database"
  parameters = { Env = "example"}
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
  name        ="${var.name}-2-catalog"
  description = "${var.name}-2-catalog catalog database"
  parameters = { Env = "example"}
  tags = { Environment = "example" }
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
  parameters = { Env = "example"}
  tags = { Environment = "example" }
}

module "catalog_london_2" {
  # checkov:skip=CKV_TF_1
  providers = {
    aws = aws.london
  }
  source      = "./../../modules/catalog_database"
  name        = "${var.name}-2-london-catalog"
  description = "${var.name}-2-london catalog database"
  parameters = { Env = "example"}
  tags = { Environment = "example" }
}