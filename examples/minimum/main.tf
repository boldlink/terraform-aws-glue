module "glue_catalogs_frankfurt" {
  source = "./../../modules/catalog"
  catalogs = {
    "${var.name}" = {
      name        = var.name
      description = "${var.name} catalog"
    }
  }
}