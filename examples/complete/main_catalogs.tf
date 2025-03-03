/*
Ireland catalog  configurations

This example will test the global catalog encryption configurations.

Multiple Catalogs are created.
*/

# checkov:skip=CKV_TF_1
module "catalogs_ireland" {
  source = "./../../modules/catalog"
  providers = {
    aws = aws.ireland
  }
  catalogs = {
    catalog_1 = {
      name        = "${var.name}-1-catalog"
      description = "${var.name}-1-catalog using SSE-KMS encryption"
      parameters  = { env = "example" }
      tags        = { Environment = "example" }
    }
    catalog_2 = {
      name        = "${var.name}-2-catalog"
      description = "${var.name}-2-catalog using SSE-KMS encryption"
      parameters  = { env = "example" }
      tags        = { Environment = "example" }
    }
  }
  depends_on = [module.kms_ireland]
}

resource "aws_glue_catalog_table" "aws_glue_catalog_table" {
  provider      = aws.ireland
  name          = "${var.name}-table"
  database_name = "${var.name}-1-catalog"
  depends_on    = [module.catalogs_ireland]
}

# checkov:skip=CKV_TF_1
module "catalogs_london" {
  source = "./../../modules/catalog"
  providers = {
    aws = aws.london
  }
  catalogs = {
    london_catalog_1 = {
      name        = "${var.name}-1-london-catalog"
      description = "london_catalog_1 in London using SSE-KMS-WITH-SERVICE-ROLE encryption"
      parameters  = { env = "example" }
      tags        = { Environment = "example" }
    }
    london_catalog_2 = {
      name        = "${var.name}-2-london-catalog"
      description = "london_catalog_2 in London using SSE-KMS-WITH-SERVICE-ROLE encryption"
      parameters  = { env = "example" }
      tags        = { Environment = "example" }
    }
  }
}
