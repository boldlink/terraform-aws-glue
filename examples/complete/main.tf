provider "aws" {
  alias  = "ireland"
  region = "eu-west-1"
}

provider "aws" {
  alias  = "london"
  region = "eu-west-2"
}

provider "aws" {
  alias  = "frankfurt"
  region = "eu-central-1"
}

# Ireland Catalogs
module "kms_ireland" {
  source = "boldlink/kms/aws"
  providers = {
    aws = aws.ireland
  }
  version                 = "1.2.0"
  alias_name              = "alias/${var.name}-ireland-kms-key"
  description             = "${var.name} Example minimum kms key"
  deletion_window_in_days = 7
}

module "catalogs_ireland" {
  source = "./../../modules/catalog"
  providers = {
    aws = aws.ireland
  }
  enable_encryption                    = true
  kms_key_arn                          = module.kms_ireland.arn
  return_connection_password_encrypted = true
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

# London Region
module "role_london" {
  source  = "boldlink/iam-role/aws"
  version = "2.0.0"
  # source = "./../../../terraform-aws-iam-role/"
  providers = {
    aws = aws.london
  }
  name               = "${var.name}-london"
  assume_role_policy = data.aws_iam_policy_document.glue_assume_role_policy.json
  tags               = merge({ Environment = "example" }, local.tags)
  policies = {
    "${var.name}-london-policy" = {
      policy = data.aws_iam_policy_document.glue_role_policy.json
      tags   = merge({ Environment = "example" }, local.tags)
    }
  }
}

module "kms_london" {
  source = "boldlink/kms/aws"
  version                 = "1.2.0"
  providers = {
    aws = aws.london
  }
  alias_name              = "alias/${var.name}-london-kms-key"
  description             = "${var.name} Example minimum kms key"
  deletion_window_in_days = 7
}

resource "time_sleep" "wait_for_iam_role" {
  create_duration = "30s"
  depends_on      = [module.role_london] # or the appropriate IAM role resource reference
}

module "catalogs_london" {
  source = "./../../modules/catalog"
  providers = {
    aws = aws.london
  }
  enable_encryption                    = true
  kms_key_arn                          = module.kms_london.arn
  glue_encryption_role_arn             = module.role_london.arn
  return_connection_password_encrypted = true
  enable_glue_resource_policy          = true
  glue_resource_policy                 = data.aws_iam_policy_document.glue_resource_policy.json
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
  depends_on = [time_sleep.wait_for_iam_role]
}

module "glue_catalogs_frankfurt" {
  source = "./../../modules/catalog"
  providers = {
    aws = aws.frankfurt
  }
  catalogs = {
    frankfurt_catalog = {
      name        = "${var.name}-frankfurt-catalog"
      description = "${var.name}-frankfurt-catalog in Frankfurt with no encryption"
      parameters  = { env = "example" }
      tags        = { Environment = "example" }
    }
  }
}