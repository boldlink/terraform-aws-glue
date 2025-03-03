output "glue_encryption_settings" {
  value = aws_glue_data_catalog_encryption_settings.main.*.id
}

output "glue_resource_policy" {
  value = aws_glue_resource_policy.this.*.policy
}