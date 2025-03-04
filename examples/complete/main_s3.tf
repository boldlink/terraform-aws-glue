module "ireland_s3_bucket" {
  # checkov:skip=CKV_TF_1
  source  = "boldlink/s3/aws"
  version = "2.5.1"
  providers = {
    aws = aws.ireland
  }
  bucket = "${var.name}-${local.ireland_region}"
  tags   = merge({ "Name" = "${var.name}-${local.ireland_region}" }, local.tags)
}