module "catalog" {
  # checkov:skip=CKV_TF_1
  source      = "./../../modules/catalog_database"
  name        = var.name
  description = "${var.name} catalog"
}

module "role" {
  # checkov:skip=CKV_TF_1
  source             = "boldlink/iam-role/aws"
  version            = "2.0.0"
  name               = "${var.name}-minimal"
  assume_role_policy = data.aws_iam_policy_document.glue_crawler_trust.json
  policies = {
    "${var.name}-minimal-policy" = {
      policy = data.aws_iam_policy_document.glue_crawler_policy.json
    }
  }
}

resource "time_sleep" "wait_for_role" {
  create_duration = "30s"
  depends_on      = [module.role]
}

module "bucket" {
  # checkov:skip=CKV_TF_1
  source  = "boldlink/s3/aws"
  version = "2.5.1"
  bucket  = "${var.name}-minimum-${local.account_id}"
  tags    = merge({ "Name" = "${var.name}-minimum-${local.account_id}" })
}

module "crawler" {
  # checkov:skip=CKV_TF_1
  source         = "./../../modules/crawler"
  name           = var.name
  role           = module.role.arn
  database_name  = var.name
  s3_target_path = "s3://${var.name}-minimum-${local.account_id}/data/"
  tags           = { Environment = "example" }
  depends_on     = [module.catalog, module.bucket, module.role, time_sleep.wait_for_role]
}
