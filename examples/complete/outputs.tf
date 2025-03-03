output "ireland_crawlers" {
  value = {
    names = module.ireland_glue_crawlers.crawler_names
    ids   = module.ireland_glue_crawlers.crawler_ids
  }
}

output "catalogs_london" {
  value = {
    names = module.catalogs_london.data_catalog_names
    arns  = module.catalogs_london.data_catalog_arns
  }
}

output "catalogs_ireland" {
  value = {
    names = module.catalogs_ireland.data_catalog_names
    arns  = module.catalogs_ireland.data_catalog_arns
  }
}

output "glue_resource_policy_london" {
  value = {
    names = module.glue_global_settings_london.glue_resource_policy
  }
}
