output "name" {
  description = "The name of the created Glue catalog database."
  value       = aws_glue_catalog_database.this.name
}

output "arn" {
  description = "The ARNs of the Glue catalog databases created."
  value       = aws_glue_catalog_database.this.arn
}
