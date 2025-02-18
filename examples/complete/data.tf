data "aws_region" "current" {
  provider = aws.london
}

data "aws_partition" "current" {
  provider = aws.london
}

data "aws_caller_identity" "current" {
  provider = aws.london
}

data "aws_iam_policy_document" "glue_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["glue.${local.dns_suffix}"]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

data "aws_iam_policy_document" "glue_role_policy" {
  statement {
    sid = "AllowKMSOperations"
    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "glue_resource_policy" {
  statement {
    sid    = "AllowReadWriteIfProjectTagMatches"
    effect = "Allow"
    # Allow all principals (you can further restrict this if needed)
    principals {
      type        = "Service"
      identifiers = ["glue.${local.dns_suffix}"]
    }
    actions = [
      "glue:GetDatabase",
      "glue:GetDatabases",
      "glue:GetTable",
      "glue:GetTables",
      "glue:CreateDatabase",
      "glue:UpdateDatabase",
      "glue:DeleteDatabase",
      "glue:CreateTable",
      "glue:UpdateTable",
      "glue:DeleteTable"
    ]
    resources = ["arn:${local.partition}:glue:${local.region}:${local.account_id}:*:*"]

    condition {
      test     = "StringEquals"
      variable = "aws:ProjectTag/"
      values   = ["example"]
    }
  }
}