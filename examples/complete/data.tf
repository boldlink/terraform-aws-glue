data "aws_region" "london" {
  provider = aws.london
}

data "aws_region" "ireland" {
  provider = aws.ireland
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
    actions = ["sts:AssumeRole"]
  }
}

# checkov:skip=CKV_AWS_111: Reason - this configuration is intentionally for testing only and not production ready
# checkov:skip=CKV_AWS_356: Reason - this configuration is intentionally for testing only and not production ready
data "aws_iam_policy_document" "glue_catalog_role_policy" {
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

data "aws_iam_policy_document" "glue_resource_policy_london" {
  provider = aws.london
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
      "glue:DeleteTable",
    ]
    resources = ["arn:${local.partition}:glue:${local.london_region}:${local.account_id}:*:*"]

    condition {
      test     = "StringEquals"
      variable = "aws:ProjectTag/"
      values   = ["example"]
    }
  }
}


data "aws_iam_policy_document" "ireland_glue_crawler_policy_doc" {
  provider = aws.ireland
  statement {
    sid = "GlueCrawlerActions"
    actions = [
      "glue:GetDatabase",
      "glue:GetDatabases",
      "glue:GetTable",
      "glue:GetTables",
      "glue:GetPartition",
      "glue:GetPartitions",
      "glue:CreateTable",
      "glue:UpdateTable",
      "glue:DeleteTable",
      "glue:GetSecurityConfiguration"
    ]
    resources = ["*"]
  }

  statement {
    sid = "S3AccessForCrawler"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::my-glue-crawler-bucket",
      "arn:aws:s3:::my-glue-crawler-bucket/*"
    ]
  }
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

