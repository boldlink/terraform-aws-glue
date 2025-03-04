# # resource "aws_glue_catalog_table" "ireland_catalog_1_table" {
# #   provider      = aws.ireland
# #   name          = "${var.name}-table"
# #   database_name = "${var.name}-1-catalog"

# #   storage_descriptor {
# #     location      = "s3://${var.name}-${local.ireland_region}/data/"  # Must be a valid S3 URI
# #     input_format  = "org.apache.hadoop.mapred.TextInputFormat"
# #     output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

# #     columns {
# #       name = "id"
# #       type = "string"
# #     }
# #     columns {
# #       name = "name"
# #       type = "string"
# #     }

# #     serde_info {
# #       name                  = "default_serde"
# #       serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
# #     }
# #   }

# #   table_type = "EXTERNAL_TABLE"
# # }

# # checkov:skip=CKV_TF_1
# module "ireland_glue_crawlers" {
#   # checkov:skip=CKV_TF_1
#   source = "./../../modules/crawler"
#   providers = {
#     aws = aws.ireland
#   }
#   crawlers = {
#     s3_crawler = {
#       name                   = "${var.name}s3-only-crawler"
#       role                   = module.role_ireland.arn         # Replace with your IAM role ARN
#       database_name          = "${var.name}-1-ireland-catalog" # A pre-created Glue database resource
#       description            = "${var.name} Crawler that scans an S3 source and auto-creates the table"
#       schedule               = "cron(15 12 * * ? *)"
#       classifiers            = []
#       configuration          = null
#       security_configuration = null
#       schema_change_policy = {
#         delete_behavior = "LOG"
#         update_behavior = "UPDATE_IN_DATABASE"
#       }
#       targets = {
#         s3_targets = [{
#           path       = "s3://${var.name}-${local.ireland_region}/data/"
#           exclusions = ["**/tmp/*"]
#         }]
#       }
#       tags = { Environment = "Prod" }
#     }
#     # jdbc_crawler = {
#     #   name                   = "jdbc-only-crawler"
#     #   role                   = module.ireland_crawler_role.arn # Replace with your IAM role ARN
#     #   database_name          = "${var.name}-2-ireland-catalog" # A pre-created Glue database resource
#     #   description            = "Crawler that scans a JDBC source"
#     #   schedule               = "cron(30 12 * * ? *)"
#     #   classifiers            = []
#     #   configuration          = null
#     #   security_configuration = null
#     #   schema_change_policy = {
#     #     delete_behavior = "LOG"
#     #     update_behavior = "UPDATE_IN_DATABASE"
#     #   }
#     #   targets = {
#     #     jdbc_targets = [{
#     #       connection_name = "my-jdbc-connection" # Your configured Glue JDBC connection name
#     #       path            = "jdbc:mysql://localhost:3306/example?user=example&password=example"
#     #       exclusions      = []
#     #     }]
#     #     dynamo_db_targets = []
#     #     catalog_targets   = []
#     #   }
#     #   tags = { Environment = "example" }
#     # }
#     # catalog_crawler = {
#     #   name                   = "catalog-only-crawler"
#     #   role                   = module.iam_role.arn    # Replace with your IAM role ARN
#     #   database_name          = aws_glue_catalog_database.example.name
#     #   description            = "Crawler that uses an existing catalog table as its source"
#     #   schedule               = "cron(0 12 * * ? *)"
#     #   classifiers            = []
#     #   configuration          = null
#     #   security_configuration = null
#     #   schema_change_policy = {
#     #     delete_behavior = "LOG"
#     #     update_behavior = "UPDATE_IN_DATABASE"
#     #   }
#     #   targets = {
#     #     s3_targets        = []  # No S3 target
#     #     jdbc_targets      = []
#     #     dynamo_db_targets = []
#     #     catalog_targets = [{
#     #       database_name = aws_glue_catalog_database.example.name
#     #       table_name    = aws_glue_catalog_table.precreated_table.name
#     #     }]
#     #   }
#     #   tags = { Environment = "example" }
#     # }
#     # dynamodb_crawler = {
#     #   name                   = "dynamodb-only-crawler"
#     #   role                   = module.iam_role.arn    # Replace with your IAM role ARN
#     #   database_name          = aws_glue_catalog_database.example.name  # A pre-created Glue database resource
#     #   description            = "Crawler that scans a DynamoDB source"
#     #   schedule               = "cron(45 12 * * ? *)"
#     #   classifiers            = []
#     #   configuration          = null
#     #   security_configuration = null
#     #   schema_change_policy = {
#     #     delete_behavior = "LOG"
#     #     update_behavior = "UPDATE_IN_DATABASE"
#     #   }
#     #   targets = {
#     #     s3_targets        = []  # Not using S3
#     #     jdbc_targets      = []
#     #     dynamo_db_targets = [{
#     #       path = "dynamodb://my-dynamodb-table"  # Ensure this is a valid DynamoDB target URI
#     #     }]
#     #     catalog_targets   = []
#     #   }
#     #   tags = { Environment = "example" }
#     # }
#   }
#   # depends_on = [docker_container.mysql]
# }


# ##############################
# # Crawler Multiple Sources
# ##############################
# # checkov:skip=CKV_TF_1
# # module "multi_source_crawler" {
# #   source = "./modules/crawler"  # Path to your crawler module
# #   default_s3_target = "s3://default-bucket/path/"

# #   crawlers = {
# #     multi_source = {
# #       name                   = "multi-source-crawler"
# #       role                   = module.iam_role.arn   # Replace with your IAM role ARN that has proper Glue permissions.
# #       database_name          = aws_glue_catalog_database.example_db.name
# #       description            = "Crawler with S3, JDBC, DynamoDB, and Catalog sources"
# #       schedule               = "cron(15 12 * * ? *)"
# #       classifiers            = []
# #       configuration          = null
# #       security_configuration = null
# #       schema_change_policy = {
# #         delete_behavior = "LOG"
# #         update_behavior = "UPDATE_IN_DATABASE"
# #       }
# #       targets = {
# #         s3_targets = [{
# #           path       = "s3://my-s3-bucket/data/"
# #           exclusions = ["**/tmp/*"]
# #         }]
# #         jdbc_targets = [{
# #           connection_name = "my-jdbc-connection"
# #           path            = "jdbc:mysql://hostname:3306/mydatabase"
# #           exclusions      = []
# #         }]
# #         dynamo_db_targets = [{
# #           path = "dynamodb://my-dynamodb-table"
# #         }]
# #         catalog_targets = [{
# #           database_name = aws_glue_catalog_database.example_db.name
# #           table_name    = aws_glue_catalog_table.precreated_table.name
# #         }]
# #       }
# #       tags = {
# #         Environment = "Prod"
# #       }
# #     }
# #   }
# # }