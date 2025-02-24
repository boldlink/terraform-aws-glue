output "crawler_names" {
  description = "Map of crawler names created"
  value       = { for k, c in aws_glue_crawler.this : k => c.name }
}

output "crawler_ids" {
  description = "Map of crawler IDs created"
  value       = { for k, c in aws_glue_crawler.this : k => c.id }
}
