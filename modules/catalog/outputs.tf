output "data_catalog_names" {
  description = "The names of the Glue catalog databases created."
  value       = { for k, db in aws_glue_catalog_database.this : k => db.name }
}

output "data_catalog_arns" {
  description = "The ARNs of the Glue catalog databases created."
  value       = { for k, db in aws_glue_catalog_database.this : k => db.arn }
}
