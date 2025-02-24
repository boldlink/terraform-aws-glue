output "data_catalog_names" {
  description = "The names of the Glue catalog databases created."
  value       = { for k, db in aws_glue_catalog_database.this : k => db.name }
}

output "data_catalog_policy_status" {
  description = "ID of the Glue resource policy, if applied."
  value       = aws_glue_resource_policy.this[*].id
}