resource "aws_glue_classifier" "example" {
  provider = aws.ireland
  name = "${var.name}-ireland"
  csv_classifier {
    allow_single_column    = false
    contains_header        = "PRESENT"
    delimiter              = ","
    disable_value_trimming = false
    header                 = ["example1", "example2"]
    quote_symbol           = "'"
  }
}

module "crawler" {
  # checkov:skip=CKV_TF_1
  providers = {
    aws = aws.ireland
  }
  source                = "./../../modules/crawler"
  name                  = var.name
  role                  = module.role_ireland.arn
  database_name         = "${var.name}-1-catalog"
  s3_target_path        = "s3://${var.name}-complete-${local.account_id}-ireland/data/"
  s3_target_exclusions  = ["**/tmp/**"]
  description           = "Crawler to scan my S3 bucket"
  table_prefix          = "my_prefix_"
  update_behavior       = "UPDATE_IN_DATABASE"
  delete_behavior       = "LOG"
  schedule              = "cron(0 12 * * ? *)"
  recrawl_policy        = "CRAWL_EVERYTHING"
  crawler_lineage_settings = "ENABLE"
  configuration         = jsonencode({
    "Version" : 1.0,
    "CrawlerOutput" : {
      "Partitions" : { "AddOrUpdateBehavior" : "InheritFromTable" }
    }
  })
  classifiers           = ["${var.name}-ireland"]
  tags                  = { Environment = "example" }
  depends_on            = [
    module.catalogs_ireland, 
    module.ireland_s3_bucket, 
    module.role_ireland, 
    time_sleep.wait_for_ireland 
  ]
}