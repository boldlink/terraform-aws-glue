output "ireland_crawlers" {
  description = "The names and IDs of the Ireland Glue crawlers"
  value = {
    names = module.crawler.name
    ids   = module.crawler.id
  }
}

output "catalogs_london" {
  description = "The names and ARNs of the London Glue data catalogs"
  value = {
    names = module.catalog_london_1.name
    arns  = module.catalog_london_2.arn
  }
}

output "catalogs_ireland" {
  description = "The names and ARNs of the Ireland Glue data catalogs"
  value = {
    names = module.catalog_ireland_1.name
    arns  = module.catalog_ireland_2.arn
  }
}

output "glue_resource_policy_london" {
  description = "The Glue resource policy for the London region"
  value = {
    names = module.glue_global_settings_london.glue_resource_policy
  }
}

output "glue_encryption_settings" {
  value = module.glue_global_settings_london.glue_encryption_settings
  description = "The ID of the Glue Data Catalog encryption settings"
}