# checkov:skip=CKV_TF_1
module "role_ireland" {
  source  = "boldlink/iam-role/aws"
  version = "2.0.0"
  providers = {
    aws = aws.ireland
  }
  name               = "${var.name}-ireland"
  assume_role_policy = data.aws_iam_policy_document.glue_assume_role_policy.json
  tags               = merge({ Environment = "example" }, local.tags)
  policies = {
    "${var.name}-ireland" = {
      policy = data.aws_iam_policy_document.ireland_glue_crawler_policy_doc.json
      tags   = merge({ Environment = "example" }, local.tags)
    }
  }
}

resource "time_sleep" "wait_for_ireland" {
  create_duration = "30s"
  depends_on      = [module.role_ireland, module.kms_ireland]
}

# checkov:skip=CKV_TF_1
module "role_london" {
  source  = "boldlink/iam-role/aws"
  version = "2.0.0"
  providers = {
    aws = aws.london
  }
  name               = "${var.name}-london"
  assume_role_policy = data.aws_iam_policy_document.glue_assume_role_policy.json
  tags               = merge({ Environment = "example" }, local.tags)
  policies = {
    "${var.name}-london" = {
      policy = data.aws_iam_policy_document.glue_catalog_role_policy.json
      tags   = merge({ Environment = "example" }, local.tags)
    }
  }
}

resource "time_sleep" "wait_for_london" {
  create_duration = "30s"
  depends_on      = [module.role_london]
}
