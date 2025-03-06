data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "glue_crawler_trust" {
  statement {
    sid    = "AllowGlueServiceAssumeRole"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

/*
Note this policy is for example and testing purposes only. Please ensure you follow the 
principle of least privilege when implementing your crawler in Production.
*/
data "aws_iam_policy_document" "glue_crawler_policy" {
  statement {
    sid    = "S3Access"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "GlueActions"
    effect = "Allow"
    actions   = ["glue:*"]
    resources = ["*"]
  }
}