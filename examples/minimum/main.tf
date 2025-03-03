module "glue_catalog_minimal" {
  source = "./../../modules/catalog"
  catalogs = {
    "${var.name}" = {
      name        = var.name
      description = "${var.name} catalog"
    }
  }
}

module "role" {
  source  = "boldlink/iam-role/aws"
  version = "2.0.0"
  name               = "${var.name}-minimal"
  assume_role_policy = data.aws_iam_policy_document.glue_crawler_trust.json
  policies = {
    "${var.name}-minimal-policy" = {
      policy = data.aws_iam_policy_document.glue_crawler_policy.json
    }
  }
}

module "glue_crawlers" {
  source = "./../../modules/crawler"
  crawlers = {
    "${var.name}-minimal" = {
      name          = "${var.name}-minimal"
      role          = module.role.arn
      database_name = var.name
    }
  }
}

module "glue_global_security_settings" {
  source = "./../../modules/global"
}
