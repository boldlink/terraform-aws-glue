# checkov:skip=CKV_TF_1
module "kms_ireland" {
  source  = "boldlink/kms/aws"
  version = "1.2.0"
  providers = {
    aws = aws.ireland
  }
  alias_name              = "alias/${var.name}-ireland-kms-key"
  description             = "${var.name} Example minimum kms key"
  deletion_window_in_days = 7
}

# checkov:skip=CKV_TF_1
module "kms_london" {
  source  = "boldlink/kms/aws"
  version = "1.2.0"
  providers = {
    aws = aws.london
  }
  alias_name              = "alias/${var.name}-london-kms-key"
  description             = "${var.name} Example minimum kms key"
  deletion_window_in_days = 7
}