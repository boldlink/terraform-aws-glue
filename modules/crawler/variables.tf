variable "name" {
  description = "Name of the Glue Crawler"
  type        = string
}

variable "role" {
  description = "IAM Role ARN that the Glue Crawler assumes"
  type        = string
}

variable "database_name" {
  description = "The Glue database name where the crawler’s output will be stored"
  type        = string
}

variable "s3_target_path" {
  description = "The S3 path that the crawler will scan (e.g., s3://bucket/path/)"
  type        = string
}

variable "s3_target_exclusions" {
  description = "List of S3 path patterns to exclude from crawling"
  type        = list(string)
  default     = []
}

variable "description" {
  description = "Description of the Glue Crawler"
  type        = string
  default     = ""
}

variable "table_prefix" {
  description = "Table prefix for tables created by the crawler"
  type        = string
  default     = ""
}

variable "update_behavior" {
  description = "Policy for updating the schema (e.g., UPDATE_IN_DATABASE)"
  type        = string
  default     = "UPDATE_IN_DATABASE"
}

variable "delete_behavior" {
  description = "Policy for handling deletes (e.g., LOG)"
  type        = string
  default     = "LOG"
}

variable "schedule" {
  description = "Cron expression to schedule the crawler (optional)"
  type        = string
  default     = null
}

variable "recrawl_policy" {
  description = "Recrawl policy behavior (e.g., CRAWL_EVERYTHING or CRAWL_NEW_FOLDERS_ONLY)"
  type        = string
  default     = ""
}

variable "crawler_lineage_settings" {
  description = "Lineage configuration for the crawler (e.g., ENABLE or DISABLE)"
  type        = string
  default     = ""
}

variable "configuration" {
  description = "A JSON string representing the crawler configuration"
  type        = string
  default     = ""
}

variable "classifiers" {
  description = "List of classifier names for the crawler"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to assign to the crawler"
  type        = map(string)
  default     = {}
}
